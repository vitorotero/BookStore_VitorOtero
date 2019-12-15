//
//  RMVolumeInfo.swift
//  BookStore_VitorOtero
//
//  Created by VitorOtero on 15/12/2019.
//  Copyright © 2019 VitorOtero. All rights reserved.
//
import Foundation
import RealmSwift

final class RMVolumeInfo: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var subtitle: String = ""
    dynamic var authors: List<String> = List<String>()
    @objc dynamic var desc: String = ""
    @objc dynamic var imageLinks: RMImageInfo? = nil
}

extension RMVolumeInfo: DomainConvertibleType {
    func asDomain() -> VolumeInfo {
        return VolumeInfo(title: title,
                          subtitle: subtitle,
                          authors: authors.toArray(),
                          description: desc,
                          imageLinks: imageLinks?.asDomain())
    }
}

extension VolumeInfo: RealmRepresentable {
    var uid: String {
        return "\(title)"
    }
    
    func asRealm() -> RMVolumeInfo {
        let newAuthors = List<String>()
        authors?.forEach({ string in
            newAuthors.append(string)
        })
        
        return RMVolumeInfo.build { object in
            object.title = title
            object.subtitle = subtitle ?? ""
            object.authors = newAuthors
            object.desc = description ?? ""
            object.imageLinks = imageLinks?.asRealm()
        }
    }
}
