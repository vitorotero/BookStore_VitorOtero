//
//  RMImageInfo.swift
//  BookStore_VitorOtero
//
//  Created by VitorOtero on 15/12/2019.
//  Copyright © 2019 VitorOtero. All rights reserved.
//

import Foundation
import RealmSwift

final class RMImageInfo: Object {
    @objc dynamic var smallThumbnail: String = ""
    @objc dynamic var thumbnail: String = ""
    
    override static func primaryKey() -> String? {
        return "thumbnail"
    }
}

extension RMImageInfo: DomainConvertibleType {
    func asDomain() -> ImageInfo {
        return ImageInfo(smallThumbnail: smallThumbnail,
                         thumbnail: thumbnail)
    }
}

extension ImageInfo: RealmRepresentable {
    var uid: String {
        return "\(thumbnail)"
    }
    
    func asRealm() -> RMImageInfo {
        return RMImageInfo.build { object in
            object.smallThumbnail = smallThumbnail
            object.thumbnail = thumbnail
        }
    }
}
