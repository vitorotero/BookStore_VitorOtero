//
//  Routable.swift
//  BookStore_VitorOtero
//
//  Created by VitorOtero on 14/12/2019.
//  Copyright © 2019 VitorOtero. All rights reserved.
//

import Foundation
import RxSwift

enum APIError: Error {
    case http(Error)
    case custom(reason: String)
    case noInternetConnection
    case timeout(message: String)
}

enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}

protocol Routable {
    var url: URL { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var headers: [String: String]? { get }
    var paramsJson: String? { get }
    var paramsQueryString: [URLQueryItem]? { get }
    var request: URLRequest { get }
}

extension Routable {
    var url: URL {
        return URL(string: "https://www.googleapis.com/books/v1/")!
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json",
                "Accept": "application/json"]
    }
    
    var request: URLRequest {
        var request = URLRequest(url: URL(string: "\(self.url)\(self.path)/")!)
        request.httpMethod = self.method.rawValue
        request.allHTTPHeaderFields = self.headers
        
        if self.paramsQueryString != nil {
            let urlComponents = NSURLComponents(string: ("\(self.url)\(self.path)/"))
            urlComponents?.queryItems = self.paramsQueryString
            request.url = urlComponents?.url
        } else if self.paramsJson != nil {
            request.httpBody = self.paramsJson?.data(using: .utf8)
        }
        
        return request
    }
}

struct ApiManager {
    
    private let session: URLSession!
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func request<T: Decodable>(router: Routable, type: T.Type) -> Observable<T> {
        var remoteTask: URLSessionTask!
        
        return Observable<T>.create({ observer -> Disposable in
            remoteTask = URLSession.shared.dataTask(with: router.request) { data, _ , error in
                
                guard let dataReceived = data else {
                    observer.onError(APIError.custom(reason: "Ocorreu um erro"))
                    observer.onCompleted()
                    return
                }
                do {
                    let objectResponse = try JSONDecoder().decode(T.self, from: dataReceived)
                    observer.onNext(objectResponse)
                    observer.onCompleted()
                } catch let error {
                  observer.onError(APIError.http(error))
                    observer.onCompleted()
                }
            }
            
            remoteTask.resume()
            
            return Disposables.create {
                remoteTask.cancel()
            }
        })
    }

}
