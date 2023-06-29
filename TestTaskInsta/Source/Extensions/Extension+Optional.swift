//
//  Extension+Optional.swift
//  TestTaskInsta
//
//  Created by Анна Яцун on 28.06.2023.
//

import Foundation


extension Optional {

func `do`(_ execute: (Wrapped) -> ()) {
    self.map(execute)
    }
}
