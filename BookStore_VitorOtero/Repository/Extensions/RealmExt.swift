//
//  RealmExt.swift
//  BookStore_VitorOtero
//
//  Created by VitorOtero on 15/12/2019.
//  Copyright © 2019 VitorOtero. All rights reserved.
//

import Foundation
import Realm
import RealmSwift
import RxSwift

extension Object {
    static func build<O: Object>(_ builder: (O) -> Void) -> O {
        let object = O()
        builder(object)
        return object
    }
}

extension Reactive where Base == Realm {
    func save<R: RealmRepresentable>(
        _ entity: R,
        update: Bool = true
    ) -> Observable<Void> where R.RealmType: Object {
        return Observable.create { observer in
            do {
                try self.base.write {
                    self.base.add(entity.asRealm(), update: .modified)
                }
                observer.onNext(())
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            
            return Disposables.create()
        }
    }
    
    func delete<R: RealmRepresentable>(_ entity: R) -> Observable<Void> where R.RealmType: Object {
        return Observable.create { observer in
            do {
                try self.base.write {
                    self.base.delete(entity.asRealm())
                }
                observer.onNext(())
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            
            return Disposables.create()
        }
    }
}
