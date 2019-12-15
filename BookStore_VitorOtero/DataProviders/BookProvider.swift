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
    func fetchFavoriteBooks() -> Observable<[Book]>
    func addFavoriteBook(book: Book) -> Observable<Void>
    func removeFavoriteBook(book: Book) -> Observable<Void>
    func fetchFavoriteBook(book: Book) -> Observable<Book>
}

class BookProvider: BookProviderProtocol {
    
    private let disposeBag = DisposeBag()
    private let apiManager = ApiManager()
    private let bookRepository = Repository<Book>()
    
    func fetchBooks(params: BookRequest) -> Observable<BookResponse> {
        return apiManager.request(router: BookRouter.list(params: params), type: BookResponse.self)
    }
    
    func fetchFavoriteBooks() -> Observable<[Book]> {
        return bookRepository.queryAll()
    }
    
    func addFavoriteBook(book: Book) -> Observable<Void> {
        return bookRepository.save(book)
    }
    
    func removeFavoriteBook(book: Book) -> Observable<Void> {
        return bookRepository.delete(book)
    }
    
    func fetchFavoriteBook(book: Book) -> Observable<Book> {
        return bookRepository.query(by: book.id)
    }
}
