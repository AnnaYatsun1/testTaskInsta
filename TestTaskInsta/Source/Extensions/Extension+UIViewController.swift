//
//  Extension+UIViewController.swift
//  TestTaskInsta
//
//  Created by Анна Яцун on 28.06.2023.
//

import UIKit
extension UIViewController {
    func setTypeSizeOfPresentation(type: UISheetPresentationController.Detent) {
        if let presentationController = self.presentationController as? UISheetPresentationController {
            presentationController.detents = [type]
        }
    }
}
