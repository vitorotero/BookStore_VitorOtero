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

class BookResponse: Codable {
    var totalItems: Int = 0
    var items: [Book]
}

class Book: Codable {
    var id: String = ""
    var etag: String = ""
    var volumeInfo: VolumeInfo?
    var saleInfo: SalesInfo?
}

class VolumeInfo: Codable {
    var title: String = ""
    var subtitle: String?
    var authors: [String]?
    var description: String?
    var imageLinks: ImageInfo?
}

class ImageInfo: Codable {
    var smallThumbnail: String = ""
    var thumbnail: String = ""
}

class SalesInfo: Codable {
    var buyLink: String?
}
