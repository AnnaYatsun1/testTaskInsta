//
//  File.swift
//  TestTaskInsta
//
//  Created by Анна Яцун on 27.06.2023.
//
import UIKit

class BaseViewController<RootViewType: BaseView<ViewModel>, ViewModel>: UIViewController {
    var rootView: RootViewType
    var viewModel: ViewModel

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        self.rootView = RootViewType(viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        
        view = rootView
    }
}
