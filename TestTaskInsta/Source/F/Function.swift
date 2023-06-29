//
//  Function.swift
//  TestTaskInsta
//
//  Created by Анна Яцун on 28.06.2023.
//

import Foundation

typealias EventHandler<Event> = (Event) -> ()
typealias VoidHandler = () -> ()

func toString(_ class: AnyClass) -> String {
    return String(describing: `class`)
}

public func cast<Value, Result>(_ value: Value) -> Result? {
    return value as? Result
}

public func when<Result>(_ condition: Bool, execute: () -> Result?) -> Result? {
    return condition ? execute() : nil
}

func dispatchOnMain(_ execute: (() -> ())?) {
    DispatchQueue.main.async {
        execute?()
    }
}

public struct F {
    
    public typealias Handler<Type> = (Type) -> ()
}
