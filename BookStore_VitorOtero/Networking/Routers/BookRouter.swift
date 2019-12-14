//
//  BookRouter.swift
//  BookStore_VitorOtero
//
//  Created by VitorOtero on 14/12/2019.
//  Copyright © 2019 VitorOtero. All rights reserved.
//

import Foundation

enum BookRouter {
    case list(params: BookRequest)
}

extension BookRouter: Routable {
    
    var method: HTTPMethod {
        switch self {
        case .list:
            return .GET
        }
    }
    
    var path: String {
        switch self {
        case .list:
            return "volumes"
        }
    }
    
    var paramsJson: String? {
        switch self {
        case .list:
            return nil
        }
    }
    
    var paramsQueryString: [URLQueryItem]? {
        switch self {
        case .list(let params):
            return [URLQueryItem(name: "q", value: params.type),
                    URLQueryItem(name: "maxResults", value: "\(params.maxResults)"),
                    URLQueryItem(name: "startIndex", value: "\(params.startIndex)")]
        }
    }
    
}
