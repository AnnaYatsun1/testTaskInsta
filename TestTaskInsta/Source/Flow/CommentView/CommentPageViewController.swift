//
//  CommentPageViewController.swift
//  TestTaskInsta
//
//  Created by Анна Яцун on 28.06.2023.
//

import UIKit

class CommentPageViewController: BaseViewController<CommentView, CommentPageViewModel> {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
       
        viewModel.getAllInfoPosts() {[weak self] in
            DispatchQueue.main.async {
                self?.rootView.tableView.reloadData()
            }
        }
    }
}

