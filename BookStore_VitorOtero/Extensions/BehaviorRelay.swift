//
//  BehaviorRelay.swift
//  BookStore_VitorOtero
//
//  Created by VitorOtero on 14/12/2019.
//  Copyright © 2019 VitorOtero. All rights reserved.
//

import RxSwift
import RxCocoa

extension BehaviorRelay where Element: RangeReplaceableCollection {
    func acceptAppending(_ element: Element.Element) {
        accept(value + [element])
    }
    
    func acceptAppending(_ element: [Element.Element]) {
        accept(value + element)
    }
}
