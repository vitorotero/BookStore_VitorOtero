//
//  RMSalesInfo.swift
//  BookStore_VitorOtero
//
//  Created by VitorOtero on 15/12/2019.
//  Copyright © 2019 VitorOtero. All rights reserved.
//

import Foundation
import RealmSwift

final class RMSalesInfo: Object {
    @objc dynamic var buyLink: String = ""
    
    override static func primaryKey() -> String? {
        return "buyLink"
    }
}

extension RMSalesInfo: DomainConvertibleType {
    func asDomain() -> SalesInfo {
        return SalesInfo(buyLink: buyLink)
    }
}

extension SalesInfo: RealmRepresentable {
    var uid: String {
        return "\(buyLink ?? UUID().uuidString)"
    }
    
    func asRealm() -> RMSalesInfo {
        return RMSalesInfo.build { object in
            object.buyLink = buyLink ?? ""
        }
    }
}
