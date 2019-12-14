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
    
    func setupViewModel(book: Book) {
        self.book.accept(book)
    }
    
    func fetchFavoriteBook() {
        
    }
    
    func addFavoriteBook() {
        
    }
    
    func removeFavoriteBook() {
        
    }
}
