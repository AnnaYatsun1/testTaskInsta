//
//  File.swift
//  TestTaskInsta
//
//  Created by Анна Яцун on 27.06.2023.
//

import Foundation


protocol APIServiceType {

    func fetchPhotos(completion: @escaping (Result<[Photo], Error>) -> Void) 
    func fetchMockComment(completion: @escaping (Result<[Photo], Error>) -> Void)
}
