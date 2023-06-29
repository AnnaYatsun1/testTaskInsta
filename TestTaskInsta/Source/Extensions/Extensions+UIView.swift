//
//  Extensions.swift
//  TestTaskInsta
//
//  Created by Анна Яцун on 27.06.2023.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach({
            addSubview($0)
        })
    }
}

extension UIView {
    
    var top: CGFloat {
        frame.origin.y
    }
    
    var bottom: CGFloat {
        frame.origin.y + height
    }
    
    var left: CGFloat {
        frame.origin.x
    }
    
    var right: CGFloat {
        frame.origin.x + width
    }
    
    var height: CGFloat {
        frame.size.height
    }
    
    var width: CGFloat {
        frame.size.width
    }
    
}
//
extension UIButton {
    func checkSelectedState(ifSelected: Bool,
                            setImageNameToNotSelected: String,
                            setImageNameToSelected: String,
                            notSelectedColer: UIColor,
                            selectedColor: UIColor,
                            poinSize: CGFloat = 18
    
    ) {
        if ifSelected{
            let image = UIImage(systemName: setImageNameToNotSelected, withConfiguration: UIImage.SymbolConfiguration(pointSize: poinSize))
            self.setImage(image, for: .normal)
            self.tintColor = notSelectedColer
        } else {
            let image = UIImage(systemName: setImageNameToSelected, withConfiguration: UIImage.SymbolConfiguration(pointSize: poinSize))
            self.setImage(image, for: .normal)
            self.tintColor = selectedColor
        }
        
 
    }
}
