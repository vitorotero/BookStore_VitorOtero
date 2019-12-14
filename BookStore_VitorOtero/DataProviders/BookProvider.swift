//
//  BookProvider.swift
//  BookStore_VitorOtero
//
//  Created by VitorOtero on 14/12/2019.
//  Copyright © 2019 VitorOtero. All rights reserved.
//

import Foundation
import RxSwift

protocol BookProviderProtocol: class {
    func fetchBooks(params: BookRequest) -> Observable<BookResponse>
}

class BookProvider: BookProviderProtocol {
    
    private let disposeBag = DisposeBag()
    private let apiManager = ApiManager()
    
    func fetchBooks(params: BookRequest) -> Observable<BookResponse> {
        return apiManager.request(router: BookRouter.list(params: params), type: BookResponse.self)
    }
    
}
