//
//  Books.swift
//  BookStore_VitorOtero
//
//  Created by VitorOtero on 14/12/2019.
//  Copyright © 2019 VitorOtero. All rights reserved.
//

import Foundation

class BookRequest: Codable {
    
    var type: String = "ios"
    var maxResults: Int = 20
    var startIndex: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case type = "q"
        case maxResults = "maxResults"
        case startIndex = "startIndex"
    }
}

class Book: Codable {
    
    var id: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
    }
    
}

