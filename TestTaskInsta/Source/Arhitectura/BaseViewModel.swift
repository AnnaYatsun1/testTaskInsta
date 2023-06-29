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
//    public let networking: NetworkingProtocol?
    
//    init(networking: NetworkingProtocol? = nil, callbackEvents: @escaping EventHandler<Events>) {
//        self.networking = networking
//        self.callbackEvents = callbackEvents
//    }
    
}
