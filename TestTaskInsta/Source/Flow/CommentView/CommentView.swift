//
//  CommentView.swift
//  TestTaskInsta
//
//  Created by Анна Яцун on 28.06.2023.
//

import UIKit

class CommentView: BaseView<CommentPageViewModel>, UITableViewDataSource, UITableViewDelegate {
    
    private var tableView: UITableView!
    
    // MARK: LifeCyrcle 
    override func configure() {
        super.configure()
        tableView = UITableView(frame: bounds,
                                style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CommentTableViewCell.self)
        addSubview(tableView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tableView.frame = .init(x: 0,
                                y: 0,
                                width: width,
                                height: height)
    }
    
    // MARK: Publick
    
    public func reloadData() {
        dispatchOnMain  {
            self.tableView.reloadData()
        }
    }
    
    // MARK: TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.comments.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell", for: indexPath) as! CommentTableViewCell
        cell.fill(with: viewModel.comments[indexPath.item])

        return cell
    }
}
