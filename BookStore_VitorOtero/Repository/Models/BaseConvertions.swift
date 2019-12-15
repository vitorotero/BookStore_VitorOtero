//
//  BaseConvertions.swift
//  BookStore_VitorOtero
//
//  Created by VitorOtero on 15/12/2019.
//  Copyright © 2019 VitorOtero. All rights reserved.
//

import Foundation

protocol RealmRepresentable {
    associatedtype RealmType: DomainConvertibleType
    
    var uid: String { get }
    func asRealm() -> RealmType
}

protocol DomainConvertibleType {
    associatedtype DomainType
    
    func asDomain() -> DomainType
}
