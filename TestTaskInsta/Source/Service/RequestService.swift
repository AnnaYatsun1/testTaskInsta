//
//  File.swift
//  TestTaskInsta
//
//  Created by Анна Яцун on 27.06.2023.
//

import Foundation

class URLBuilder {
   
    let apiUrl = "https://api.unsplash.com/photos"
    let accessKey = "r9iPw1oIYXUuPLO9ALYYaOSQaarCH27xtUZpE86P9Ak"
    func catalog() -> URL? {
        
        var components = URLComponents(string: apiUrl)
        components?.queryItems = [.init(name: "client_id", value: "r9iPw1oIYXUuPLO9ALYYaOSQaarCH27xtUZpE86P9Ak")]
 
        return components?.url
    }
    
    func comments() -> URL? {
        return URL(string: "https://test.com")
    }
}

class RequestService: APIServiceType {
    
    private let session: URLSession
    private let urlBuilder: URLBuilder
    
    init(session: URLSession = .shared, urlBuilder: URLBuilder) {
        self.session = session
        self.urlBuilder = urlBuilder
    }
    
    public func fetchMockComment(completion: @escaping (Result<[Photo], Error>) -> Void) {
        guard let url = self.urlBuilder.catalog() else { return }
        getData(url: url) { result in
            switch result {
            case let .success(data):
                print(data)
                let parser = Parser<[Photo]>()
                completion(parser.object(from: data))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    public func fetchPhotos(completion: @escaping (Result<[Photo], Error>) -> Void) {
        guard let url = self.urlBuilder.catalog() else { return }
        getData(url: url) { result in
            switch result {
            case let .success(data):
                let parser = Parser<[Photo]>()
                completion(parser.object(from: data))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    private func getData(url: URL, completion: @escaping (Result<Data, Error>) -> ()) {
        let task = self.session.dataTask(with: url) { data, responce, error in
            print(responce)
            if let error = error {
                completion(.failure(error))
            }
            if let data = data {
                completion(.success(data))
            }
        }
        task.resume()
    }
}
