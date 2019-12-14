//
//  BooksViewController.swift
//  BookStore_VitorOtero
//
//  Created by VitorOtero on 14/12/2019.
//  Copyright © 2019 VitorOtero. All rights reserved.
//

import UIKit
import RxSwift

class BooksViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var booksCollectionView: UICollectionView!
    
    // MARK: - Properties
    private let disposeBag = DisposeBag()
    private var viewModel: BooksViewModel!
    
    // MARK: - Life Cycle
    init(viewModel: BooksViewModel = BooksViewModel()) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBindView()
        setupCollectionView()
        
        viewModel.fetchBooks()
    }
    
    // MARK: - Private Methods
    private func setupView() {
        navigationItem.title = "books_view_title_label".localized
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: "iconOptions".imageAsset,
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(openActionView))
    }
    
    private func setupBindView() {
        viewModel.books
            .subscribe(onNext: { [weak self] books in
                guard let self = self, !books.isEmpty else { return }
                self.booksCollectionView.reloadData()
            })
            .disposed(by: disposeBag)
    }
    
    private func setupCollectionView() {
        booksCollectionView.register(UINib(nibName: BooksCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: BooksCollectionViewCell.identifier)
    }
    
    @objc
    private func openActionView() {
        let actionSheetController = UIAlertController(title: "books_sheets_title_label".localized,
                                                      message: nil,
                                                      preferredStyle: .actionSheet)

        let allBooksAction = UIAlertAction(title: "books_sheets_all_label".localized, style: .default) { action -> Void in
        }

        let favoritesAction = UIAlertAction(title: "books_sheets_favorites_label".localized, style: .default) { action -> Void in
        }
        
        let closeAction = UIAlertAction(title: "close".localized, style: .cancel) { action -> Void in
            actionSheetController.dismiss(animated: true)
        }
        
        actionSheetController.addAction(allBooksAction)
        actionSheetController.addAction(favoritesAction)
        actionSheetController.addAction(closeAction)
        self.present(actionSheetController, animated: true, completion: nil)

    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension BooksViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  5
        let collectionViewSize = collectionView.frame.size.width - padding
        
        return CGSize(width: collectionViewSize / 2, height: 250)
    }
    
}

// MARK: - UICollectionViewDelegate
extension BooksViewController: UICollectionViewDelegate {
        
}

// MARK: - UICollectionViewDataSource
extension BooksViewController: UICollectionViewDataSource {
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.books.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BooksCollectionViewCell.identifier, for: indexPath) as! BooksCollectionViewCell
        
        cell.setup(item: viewModel.books.value[indexPath.row])
        
        return cell
    }
    
}
