//
//  TableAdapter.swift
//  TestTaskInsta
//
//  Created by Анна Яцун on 28.06.2023.
//

import UIKit

struct EmptyModel: Codable { }
protocol AnyCellType: UITableViewCell {
    
    func fill(with model: Any, eventHandler: F.Handler<Any>?)
}

open class BaseCell<Model, Events>: UITableViewCell, AnyCellType {
    
    //MARK: -
    //MARK: Accesors
    
    public var eventHandler: F.Handler<Events>?
    
    //MARK: -
    //MARK: View Lifycycle
    
    override open func awakeFromNib() {
        super.awakeFromNib()

        self.configure()
        self.selectionStyle = UITableViewCell.SelectionStyle.none
    }
    
    open override func prepareForReuse() {
        self.eventHandler = nil
        
        super.prepareForReuse()
    }

    open func configure() {

    }
    
    //MARK: -
    //MARK: AnyCellType
    
    func fill(with model: Any, eventHandler: F.Handler<Any>?) {
        if let value = model as? Model {
            self.eventHandler = {
                eventHandler?($0)
            }
            
            self.fill(with: value)
        }
    }
    
    open func fill(with model: Model) {

    }
}



public struct SectionHeader {
    
    let view: UIView?
    let height: CGFloat
    
    static func create(color: UIColor, height: CGFloat) -> SectionHeader {
        let view = UIView()
        view.backgroundColor = color

        return SectionHeader(view: view, height: height)
    }
}

public struct Section {
    
    //MARK: -
    //MARK: Accesors
    
    let cell: AnyCellType.Type
    let header: SectionHeader?
    var models: [Any]
    let eventHandler: ((Any) -> ())?
    let isEditing: Bool
    
    //MARK: -
    //MARK: Initializations

    public init<Cell, Model, EventsType>(
        cell: Cell.Type,
        models: [Model],
        eventHandler: F.Handler<EventsType>? = nil,
        header: SectionHeader? = nil,
        isEditing: Bool = false
    )
        where Cell: BaseCell<Model, EventsType>
    {
        self.cell = cell
        self.models = models
        self.header = header
        self.isEditing = isEditing
        self.eventHandler = {
            if let event = $0 as? EventsType {
                eventHandler?(event)
            }
        }
    }

    public init<Cell, Model, EventsType>(
        cell: Cell.Type,
        model: Model,
        eventHandler: F.Handler<EventsType>? = nil,
        header: SectionHeader? = nil,
        isEditing: Bool = false
    )
        where Cell: BaseCell<Model, EventsType>
    {
        self.init(cell: cell,
                  models: [model],
                  eventHandler: eventHandler,
                  header: header,
                  isEditing: isEditing)
    }
}


public enum TableEvents {
    
    case didReloadData
    case didSelect(IndexPath)
    case didRemove(IndexPath)
    case loadNext
}

public class TableAdapter: NSObject, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    
    //MARK: -
    //MARK: Accesors
    
    public var sections = [Section]() {
        didSet {
            self.table?.reloadData()
            UIView.animate(
                withDuration: 0.0,
                delay: 0,
                options: [.overrideInheritedOptions],
                animations: { self.table?.reloadData() },
                completion: { _ in self.eventHandler?(.didReloadData) }
            )
        }
    }

    public var eventHandler: F.Handler<TableEvents>?
    
    private(set) weak var table: UITableView?
    private var isEndDragging: Bool = true
    
    //MARK: -
    //MARK: Initializations
    
    public init(table: UITableView?, cells: [UITableViewCell.Type]) {
        self.table = table
        
        super.init()
        
        table?.dataSource = self
        table?.delegate = self
        cells.forEach {
            self.table?.register($0)
        }
    }
    
    //MARK: -
    //MARK: TableView DataSource & Delegate
    
    public func reload() {
         self.table?.reloadData()
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sections[section].models.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = self.sections[indexPath.section]
        
        let cell = tableView.dequeueReusableCell(withCellClass: section.cell, for: indexPath)
        
        let value = cell as? AnyCellType
        let model = section.models[indexPath.row]
        
        value?.fill(with: model, eventHandler: section.eventHandler)
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.eventHandler?(.didSelect(indexPath))
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.sections[section].header?.view
    }

    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let header = self.sections[section]
        return header.header?.height ?? 0
    }
    
    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return self.sections[indexPath.section].isEditing
    }
    
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            self.sections[indexPath.section].models.remove(at: indexPath.row)
            self.eventHandler?(.didRemove(indexPath))
        default:
            break
        }
    }
    
    // MARK: - UIScrollViewDelegate
    
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                   withVelocity velocity: CGPoint,
                                   targetContentOffset: UnsafeMutablePointer<CGPoint>)
    {
        let distance = scrollView.contentSize.height - (targetContentOffset.pointee.y + scrollView.bounds.height)
        let isNeedLoad = scrollView.contentSize.height > scrollView.frame.height
        if distance < 20 && velocity.y > 0 && isNeedLoad {
            self.eventHandler?(.loadNext)
        }
    }
    
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.isEndDragging = false
    }
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.isEndDragging = true
    }
}
