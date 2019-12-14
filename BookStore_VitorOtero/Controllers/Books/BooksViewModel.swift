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
    
    var books = BehaviorRelay<[Book]>(value: [Book]())
//    var openDetailPhoto = BehaviorRelay<Photo?>(value: nil)
    
    init(bookProvider: BookProviderProtocol = BookProvider()) {
        self.bookProvider = bookProvider
    }
    
    func fetchBooks() {
        bookProvider.fetchBooks(params: BookRequest())
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] books in
                guard let self = self else { return }
                self.books.accept(books)
                }, onError: { erro in
                 print(erro)
            })
            .disposed(by: disposeBag)
    }
    
    func didSelected(book: Book) {
//        openDetailPhoto.accept(photo)
    }
    
}
