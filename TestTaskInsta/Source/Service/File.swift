//
//  File.swift
//  TestTaskInsta
//
//  Created by Анна Яцун on 27.06.2023.
//

import Foundation
//struct ServerError<Value: Codable>: Codable {
//
//    let error: String
//    let errors: Value?
//
//    enum CodingKeys: String, CodingKey {
//        case error = "error"
//        case errors = "errors"
//    }
//}
//
//enum NetworkModel<Element: Decodable, CustomError: Codable> {
//    case success(Element)
//    case serverError(ServerError<CustomError>)
//    case parserError(NSError)
//}
//
//struct EmptyModel: Codable { }
//
//protocol NetworkingProtocol {
//
////    var networkService: NetworkSevice { get }
////    var isReachableRelay: BehaviorRelay<Bool> { get }
////
//    // news
//    func getPhotos() -> NetworkModel<Photo, EmptyModel>
//
//}
//
//import Reachability
//
//class Networking: NetworkingProtocol {
//
//    let mainServerAPI = MainServerAPI()
//    let networkService = RequestService(urlBuilder: )
//    //NetworkSevice(urlSessionService: URLSessionService(),
//                                       parser: NetworkParser(),
//                                       autorizationService: AutorizationService())
//
//
//    // MARK: - Init and Deinit
//
//    init() {
//        self.reachability?.whenUnreachable = { [weak self] _ in
//            self?.isReachableRelay.accept(false)
//        }
//
//        self.reachability?.whenReachable = { [weak self] _ in
//            self?.isReachableRelay.accept(true)
//        }
//
//        try? self.reachability?.startNotifier()
//    }
//}
//
//
//extension Networking {
//
//    func getPhotos() -> NetworkModel<Photo, EmptyModel> {
//        let urlString = self.mainServerAPI.mainServerUrl + "articles?type=affairs&include=stats&page=\(page)"
//
//        return self.networkService.response(urlString: urlString, method: .get, autorizationType: .token)
//    }
