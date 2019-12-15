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
    var buyLink = BehaviorRelay<String?>(value: nil)
    var isFavorited = BehaviorRelay<Bool>(value: false)
    
    init(bookProvider: BookProviderProtocol = BookProvider()) {
        self.bookProvider = bookProvider
    }
    
    func setupViewModel(book: Book) {
        self.book.accept(book)
    }
    
    func openBuyLink() {
        self.buyLink.accept(book.value.saleInfo?.buyLink)
    }
    
    func fetchFavoriteBook() {
        bookProvider.fetchFavoriteBook(book: book.value)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.isFavorited.accept(true)
                },onError: { erro in
                    self.isFavorited.accept(false)
            })
            .disposed(by: disposeBag)
    }
    
    func favoriteBook() {
        if isFavorited.value {
            uncheckFavoriteBook()
        } else {
            checkFavoriteBook()
        }
    }
    
    private func checkFavoriteBook() {
        bookProvider.addFavoriteBook(book: book.value)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.isFavorited.accept(true)
                }, onError: { erro in
                    print(erro)
            })
            .disposed(by: disposeBag)
    }
    
    private func uncheckFavoriteBook() {
        bookProvider.removeFavoriteBook(book: book.value)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.isFavorited.accept(false)
                }, onError: { erro in
                    print(erro)
            })
            .disposed(by: disposeBag)
    }
}
