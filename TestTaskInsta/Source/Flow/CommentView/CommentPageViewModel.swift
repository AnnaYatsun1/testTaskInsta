//
//  CommentPageViewModel.swift
//  TestTaskInsta
//
//  Created by Анна Яцун on 28.06.2023.
//

import UIKit


enum CommentPageViewModelEvents {
 
}

class CommentPageViewModel: BaseViewModel<CommentPageViewModelEvents> {
    let requestService: RequestService
    var comments = [Photo]()
    private(set) var adapter: TableAdapter?
    
    //MARK: Init
    
     init(requestService: RequestService) {
         self.requestService = requestService
    }
    
    //MARK: Publick
    
    func getAllInfoPosts(completion: @escaping VoidHandler) {
        requestService.fetchMockComment() { [weak self] result in
            switch result {
            case let .success(model):
                self?.comments = model
                completion()
                guard let comm =  self?.comments else { return }
//                self?.updateTable(with: comm)
            case let .failure(error):
                print(error)
            }
            
        }
    }
//
    //MARK: Private
    
    private func updateTable(with models: [Photo]) {

        self.adapter?.sections = [
            Section(cell: CommentTableViewCell.self,
                    models: models ,
                    eventHandler: { [weak self] _ in  })
        ]
    }
}


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
