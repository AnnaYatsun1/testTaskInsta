//
//  CommentPageViewModel.swift
//  TestTaskInsta
//
//  Created by Анна Яцун on 28.06.2023.
//

import UIKit


enum CommentPageViewModelEvents { }
protocol CommentPageViewModelProtocol {
    var adapter: TableAdapter? { get }
    var comments: [Photo] { get }
    
    func getPosts(completion: @escaping VoidHandler)
}

class CommentPageViewModel: BaseViewModel<CommentPageViewModelEvents>,  CommentPageViewModelProtocol {
    private(set) var adapter: TableAdapter?
    private(set) var comments = [Photo]()
    
    private let requestService: APIServiceType
    
    //MARK: Init
    
     init(requestService: APIServiceType) {
         self.requestService = requestService
    }
    
    //MARK: Publick
    
    func getPosts(completion: @escaping VoidHandler) {
        requestService.fetchMockComment() { [weak self] result in
            switch result {
            case let .success(model):
                self?.comments = model
                completion()
//                self?.updateTable(with: comm)
            case let .failure(error):
                print(error)
            }
            
        }
    }

    //MARK: Private
    
    private func updateTable(with models: [Photo]) {

        self.adapter?.sections = [
            Section(cell: CommentTableViewCell.self,
                    models: models ,
                    eventHandler: { [weak self] _ in  })
        ]
    }
}

// для рефакторинга что б одна сущность отвечала а создание таблици gне заимплеменчено
extension CommentPageViewModel {

    // MARK: - Public API

    public func configureTableView(_ tableView: UITableView?) {
        let cellTypes = self.allCellTypes()

        tableView?.estimatedRowHeight = 80
        tableView?.rowHeight = UITableView.automaticDimension

        self.adapter = TableAdapter(table: tableView, cells: cellTypes)
        self.adapter?.sections = []
    }

    // MARK: - Private API

    private func allCellTypes() -> [UITableViewCell.Type] {
        return [
            CommentTableViewCell.self
        ]
    }
}
