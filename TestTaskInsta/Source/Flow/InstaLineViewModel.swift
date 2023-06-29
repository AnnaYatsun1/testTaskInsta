//
//  File.swift
//  TestTaskInsta
//
//  Created by Анна Яцун on 27.06.2023.
//

import Foundation

enum FistPageViewModelEvents {
    case openShareScreen
    case openMoreScreen
    case openCommentScreen
    case reloadData
}

protocol InstaLineViewModelProtocol {
    var photos: [Photo] { get }
    func getPosts(completion: @escaping VoidHandler)
}

class InstaLineViewModel: BaseViewModel<FistPageViewModelEvents>, InstaLineViewModelProtocol {
    
    private let requestService: APIServiceType
    private(set) var photos = [Photo]()

    // MARK: Init
    
     init(requestService: APIServiceType) {
         self.requestService = requestService
    }
    
    public func getPosts(completion: @escaping VoidHandler) {
        requestService.fetchPhotos() {[weak self] result in
            switch result {
            case let .success(model):
                self?.photos = model
                completion() // update table internal event
            case let .failure(error):
                print(error) //  internal event show popap with error
            }
        }
    }
}
