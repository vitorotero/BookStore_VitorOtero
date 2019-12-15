//
//  BookDetailViewController.swift
//  BookStore_VitorOtero
//
//  Created by VitorOtero on 14/12/2019.
//  Copyright © 2019 VitorOtero. All rights reserved.
//

import UIKit
import RxSwift

class BookDetailViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    
    
    // MARK: - Properties
    private let disposeBag = DisposeBag()
    private var viewModel: BookDetailViewModel!
    
    // MARK: - Life Cycle
    init(book: Book, viewModel: BookDetailViewModel = BookDetailViewModel()) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        self.viewModel.setupViewModel(book: book)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBindView()
        
        viewModel.fetchFavoriteBook()
    }
    
    // MARK: - Private Methods
    private func setupView() {
        navigationItem.title = "book_detail_view_title_label".localized
    }
    
    private func setupBindView() {
        viewModel.book
        .subscribe(onNext: { [weak self] book in
            print(book.id)
        })
        .disposed(by: disposeBag)
    }
    
    // MARK: - Private Methods
    @IBAction func addFavoriteButtonTapped(_ sender: Any) {
        viewModel.addFavoriteBook()
    }
}
