//
//  File.swift
//  TestTaskInsta
//
//  Created by Анна Яцун on 27.06.2023.
//

import UIKit


class BaseView<ViewModel>: UIView {
    var viewModel: ViewModel
    private var buttonAction: (() -> Void)?
    
    required init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure() {
        
    }
    
    func addButtonAction(action: @escaping () -> Void) {
        buttonAction = action        
    }
}
