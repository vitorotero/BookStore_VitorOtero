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
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleBookLabel: UILabel!
    @IBOutlet weak var authorTitleLabel: UILabel!
    @IBOutlet weak var authorsLabel: UILabel!
    @IBOutlet weak var buyTitleLabel: UILabel!
    @IBOutlet weak var buyLinkButton: UIButton!
    @IBOutlet weak var descriptionTitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
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
        
        buyLinkButton.setTitleColor(UIColor.systemBlue, for: .normal)
        titleLabel.text = "book_detail_view_book_title_label".localized
        authorTitleLabel.text = "book_detail_view_authors_label".localized
        buyTitleLabel.text = "book_detail_view_buy_label".localized
        descriptionTitleLabel.text = "book_detail_view_description_label".localized
        
        thumbnailImageView.kf.indicatorType = .activity
        thumbnailImageView.image = "iconBook".imageAsset
    }
    
    private func setupBindView() {
        viewModel.book
            .subscribe(onNext: { [weak self] book in
                guard let self = self else { return }
                
                if let images = book.volumeInfo?.imageLinks {
                    let url = URL(string: images.thumbnail)
                    self.thumbnailImageView.kf.setImage(with: url)
                }
                
                self.titleBookLabel.text = book.volumeInfo?.title
                
                if let authors = book.volumeInfo?.authors {
                    self.authorsLabel.text = authors.joined(separator: ", ")
                } else {
                    self.authorsLabel.isHidden = true
                    self.authorTitleLabel.isHidden = true
                }
                
                if let buyLink = book.saleInfo?.buyLink {
                    self.buyLinkButton.setTitle(buyLink, for: .normal)
                } else {
                    self.buyLinkButton.isHidden = true
                    self.buyTitleLabel.isHidden = true
                }
                
                if let description = book.volumeInfo?.description {
                    self.descriptionLabel.text = description
                } else {
                    self.descriptionLabel.isHidden = true
                    self.descriptionTitleLabel.isHidden = true
                }
                
            })
            .disposed(by: disposeBag)
        
        viewModel.isFavorited
            .subscribe(onNext: { [weak self] favorited in
                guard let self = self else { return }
                let title = favorited ? "book_detail_view_unfavorite_label".localized : "book_detail_view_favorite_label".localized
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: title,
                                                                         style: .done,
                                                                         target: self,
                                                                         action: #selector(self.favoriteButtonTapped))
            })
            .disposed(by: disposeBag)
        
        viewModel.buyLink
            .subscribe(onNext: { buyLink in
                if let link = buyLink, let url = URL(string: link) {
                    UIApplication.shared.open(url, options: [:])
                }
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Private Methods
    @IBAction func buyLinkButtonTapped(_ sender: Any) {
        viewModel.openBuyLink()
    }
    
    @objc
    func favoriteButtonTapped(_ sender: Any) {
        viewModel.favoriteBook()
    }
    
}
