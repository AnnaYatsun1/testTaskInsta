//
//  Extension+UICollectionView.swift
//  TestTaskInsta
//
//  Created by Анна Яцун on 28.06.2023.
//

import UIKit

extension UICollectionView {

    func register(cells: Set<String>) {
        cells.forEach { type in
            self.register(cell: type)
        }
    }
    
    func register(cell: String) {
        let nib = UINib(nibName: cell, bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: cell)
    }
    
    func register(cellClass: AnyClass) {
        self.register(cell: toString(cellClass))
    }

//    func register(cellClasses: AnyClass...) {
//        cellClasses
//            .map(toString)
//            .set
//            .forEach(self.register(cell:))
//    }

    func register(supplementaryView: String, ofKind kind: String) {
        let nib = UINib(nibName: supplementaryView, bundle: nil)
        self.register(nib,
                      forSupplementaryViewOfKind: kind,
                      withReuseIdentifier: supplementaryView)
    }
    
    func register(supplementaryViewClass: UICollectionReusableView.Type, ofKind kind: String) {
        self.register(supplementaryView: "\(supplementaryViewClass)", ofKind: kind)
    }
    
    public func dequeueReusableCell<T: UICollectionViewCell>(
        withCellClass cellClass: AnyClass,
        for indexPath: IndexPath
    )
        -> T
    {
        let cell = self.dequeueReusableCell(withReuseIdentifier: toString(cellClass), for: indexPath)
        
        guard let cast = cell as? T else {
            fatalError("Dont fine cell")
        }
        
        return cast
    }
}
