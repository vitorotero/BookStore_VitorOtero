//
//  ObservableExt.swift
//  BookStore_VitorOtero
//
//  Created by VitorOtero on 15/12/2019.
//  Copyright © 2019 VitorOtero. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


extension Observable where Element: Sequence, Element.Iterator.Element: DomainConvertibleType {
    typealias DomainType = Element.Iterator.Element.DomainType
    
    func mapToDomain() -> Observable<[DomainType]> {
        return map { $0.mapToDomain() }
    }
}

extension Sequence where Iterator.Element: DomainConvertibleType {
    typealias Element = Iterator.Element
    
    func mapToDomain() -> [Element.DomainType] {
        return map { $0.asDomain() }
    }
}
