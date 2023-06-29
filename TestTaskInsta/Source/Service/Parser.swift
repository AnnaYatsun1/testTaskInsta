//
//  File.swift
//  TestTaskInsta
//
//  Created by Анна Яцун on 27.06.2023.
//

import Foundation

enum ParserErrors: Error {
    
    case dataError
}

class Parser<Object: Decodable> {
    
    func object(from data: Data) -> Result<Object, Error> {
        guard let model = try? JSONDecoder().decode(Object.self, from: data) else {
            return .failure(ParserErrors.dataError)
        }
        return .success(model)
        
        
        
//        return data
////            .flatMap {
//              let model = try? JSONDecoder().decode(Object.self, from: $0)
////            }
//            .map {
//                .success($0)
//            }
//            ?? .failure(ParserErrors.dataError)
    }
}
