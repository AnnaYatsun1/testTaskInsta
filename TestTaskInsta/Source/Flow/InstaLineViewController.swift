//
//  File.swift
//  TestTaskInsta
//
//  Created by Анна Яцун on 27.06.2023.
//

import UIKit


class InstaLineViewController: BaseViewController<InstaLineView, InstaLineViewModel> {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        viewModel.getPosts() {[weak self] in
            self?.rootView.reloadData()
        }
    }
}



