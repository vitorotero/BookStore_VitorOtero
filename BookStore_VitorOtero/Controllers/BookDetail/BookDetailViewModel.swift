//
//  BookDetailViewModel.swift
//  BookStore_VitorOtero
//
//  Created by VitorOtero on 14/12/2019.
//  Copyright © 2019 VitorOtero. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class BookDetailViewModel {
    
    private let disposeBag: DisposeBag = DisposeBag()
    private var bookProvider: BookProviderProtocol!
    var book = BehaviorRelay<Book>(value: Book())
    
    init(bookProvider: BookProviderProtocol = BookProvider()) {
        self.bookProvider = bookProvider
    }
    
    func setupViewModel(book: Book) {
        self.book.accept(book)
    }
    
    func fetchFavoriteBook() {
        bookProvider.fetchFavoriteBook(book: book.value)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] book in
                print(book)
                },onError: { erro in
                    print(erro)
            })
            .disposed(by: disposeBag)
    }
    
    func addFavoriteBook() {
        bookProvider.addFavoriteBook(book: book.value)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                print("sucesso")
                }, onError: { erro in
                    print(erro)
            })
            .disposed(by: disposeBag)
    }
    
    func removeFavoriteBook() {
        
    }
}
