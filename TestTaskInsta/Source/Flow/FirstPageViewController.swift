//
//  File.swift
//  TestTaskInsta
//
//  Created by Анна Яцун on 27.06.2023.
//

import UIKit


class FirstPageViewController: BaseViewController<FistPageView, FistPageViewModel> {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        viewModel.getAllInfoPosts() {[weak self] in
            self?.rootView.reloadData()
        }
    }
}



