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
    private var finishPagination: Bool = false
    private var safeBooks: [Book] = []
    private var favoriteBooks: [Book] = []
    
    var books = BehaviorRelay<[Book]>(value: [Book]())
    var openBookDetail = BehaviorRelay<Book?>(value: nil)
    var isFavoriteEnable = false
    
    init(bookProvider: BookProviderProtocol = BookProvider()) {
        self.bookProvider = bookProvider
    }
    
    func fetchBooks() {
        bookProvider.fetchBooks(params: bookRequest)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] bookResponse in
                guard let self = self else { return }
                
                self.books.accept(bookResponse.items ?? [])
                self.safeBooks = self.books.value
                }, onError: { erro in
                    print(erro)
            })
            .disposed(by: disposeBag)
    }
    
    func fetchMoreBooks() {
        guard !finishPagination else { return }
        bookRequest.startIndex = bookRequest.startIndex + BookRequest.paginationStep
        
        bookProvider.fetchBooks(params: bookRequest)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] bookResponse in
                guard let self = self else { return }
                
                self.finishPagination = bookResponse.items?.isEmpty ?? true
                self.books.acceptAppending(bookResponse.items ?? [])
                self.safeBooks = self.books.value
                }, onError: { erro in
                    print(erro)
            })
            .disposed(by: disposeBag)
    }
    
    func fetchFavoriteBooks() {
        bookProvider.fetchFavoriteBooks()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] books in
                guard let self = self else { return }
                self.favoriteBooks = books
                if self.isFavoriteEnable {
                    self.books.accept(self.favoriteBooks)
                }
                }, onError: { erro in
                    print(erro)
            })
            .disposed(by: disposeBag)
    }
    
    func showFavoriteBooks() {
        self.isFavoriteEnable = true
        self.books.accept(self.favoriteBooks)
    }
    
    func showAllBooks() {
        self.isFavoriteEnable = false
        self.books.accept(self.safeBooks)
    }
    
    func didSelected(book: Book) {
        openBookDetail.accept(book)
    }
    
}
