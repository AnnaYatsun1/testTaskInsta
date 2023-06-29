//
//  File.swift
//  TestTaskInsta
//
//  Created by Анна Яцун on 27.06.2023.
//

import Foundation


protocol APIServiceType {

    func getPhotos(completion: @escaping (Result<[Photo], Error>) -> ())
    
}
