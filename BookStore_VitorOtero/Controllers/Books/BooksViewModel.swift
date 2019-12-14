//
//  BooksViewModel.swift
//  BookStore_VitorOtero
//
//  Created by VitorOtero on 14/12/2019.
//  Copyright © 2019 VitorOtero. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class BooksViewModel {
    
    private var bookProvider: BookProviderProtocol!
    private let disposeBag: DisposeBag = DisposeBag()
    private var bookRequest = BookRequest()
    
    var books = BehaviorRelay<[Book]>(value: [Book]())
//    var openBookDetail = BehaviorRelay<Book?>(value: nil)
    
    init(bookProvider: BookProviderProtocol = BookProvider()) {
        self.bookProvider = bookProvider
    }
    
    func fetchBooks() {
        bookProvider.fetchBooks(params: bookRequest)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] bookResponse in
                guard let self = self else { return }
                self.books.accept(bookResponse.items)
                }, onError: { erro in
                 print(erro)
            })
            .disposed(by: disposeBag)
    }
    
    func didSelected(book: Book) {
//        openBookDetail.accept(book)
    }
    
}
