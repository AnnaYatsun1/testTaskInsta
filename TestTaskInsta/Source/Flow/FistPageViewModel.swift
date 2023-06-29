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

class FistPageViewModel: BaseViewModel<FistPageViewModelEvents> {
    let requestService: APIServiceType
    var photos = [Photo]()

     init(requestService: APIServiceType) {
         self.requestService = requestService
         
    }
    
    func getAllInfoPosts(completion: @escaping VoidHandler) {
        requestService.fetchPhotos() {[weak self] result in
            switch result {
            case let .success(model):
                self?.photos = model
                print(self?.photos.count)
                completion()
               
              // update table internal event
            case let .failure(error):
                print(error)
                //  internal event show popap with error
            }
        }
    }

}
