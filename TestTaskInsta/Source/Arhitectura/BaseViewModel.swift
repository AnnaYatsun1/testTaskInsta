//
//  File.swift
//  TestTaskInsta
//
//  Created by Анна Яцун on 27.06.2023.
//

import Foundation

class BaseViewModel<Events> {
    
    typealias EventHandler<Event> = (Event) -> ()
    var callbackEvents: EventHandler<Events>?
    
}
