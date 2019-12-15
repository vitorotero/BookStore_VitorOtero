//
//  RMBook.swift
//  BookStore_VitorOtero
//
//  Created by VitorOtero on 15/12/2019.
//  Copyright © 2019 VitorOtero. All rights reserved.
//

import Foundation
import RealmSwift

final class RMBook: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var etag: String = ""
    @objc dynamic var volumeInfo: RMVolumeInfo? = nil
    @objc dynamic var saleInfo: RMSalesInfo? = nil
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

extension RMBook: DomainConvertibleType {
    func asDomain() -> Book {
        return Book(id: id,
                    etag: etag,
                    volumeInfo: volumeInfo?.asDomain(),
                    saleInfo: saleInfo?.asDomain())
    }
}

extension Book: RealmRepresentable {
    var uid: String {
        return "\(id)"
    }
    
    func asRealm() -> RMBook {
        return RMBook.build { object in
            object.id = id
            object.etag = etag
            object.volumeInfo = volumeInfo?.asRealm()
            object.saleInfo = saleInfo?.asRealm()
        }
    }
}
