//
//  Books.swift
//  BookStore_VitorOtero
//
//  Created by VitorOtero on 14/12/2019.
//  Copyright © 2019 VitorOtero. All rights reserved.
//

import Foundation

struct BookRequest: Codable {
    
    static let paginationStep = 20
    
    var type: String = "ios"
    var maxResults: Int = 20
    var startIndex: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case type = "q"
        case maxResults = "maxResults"
        case startIndex = "startIndex"
    }
}

struct BookResponse: Codable {
    var totalItems: Int = 0
    var items: [Book]?
}

struct Book: Codable {
    var id: String = ""
    var etag: String = ""
    var volumeInfo: VolumeInfo?
    var saleInfo: SalesInfo?
}

struct VolumeInfo: Codable {
    var title: String = ""
    var subtitle: String?
    var authors: [String]?
    var description: String?
    var imageLinks: ImageInfo? = nil
}

struct ImageInfo: Codable {
    var smallThumbnail: String = ""
    var thumbnail: String = ""
}

struct SalesInfo: Codable {
    var buyLink: String?
}
