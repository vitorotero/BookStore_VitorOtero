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
        
//        viewModel.fetchPhotos()
    }
    
    // MARK: - Private Methods
    private func setupView() {
        viewModel.fetchBooks()
    }
    
    private func setupBindView() {
        
    }
    
    private func setupCollectionView() {
        booksCollectionView.register(BooksCollectionViewCell.self, forCellWithReuseIdentifier: BooksCollectionViewCell.identifier)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        booksCollectionView.setCollectionViewLayout(layout, animated: true)
    }
    
}

extension BooksViewController: UICollectionViewDelegate {
    
}

extension BooksViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BooksCollectionViewCell.identifier, for: indexPath) as! BooksCollectionViewCell
        
        return cell
    }
        
}
