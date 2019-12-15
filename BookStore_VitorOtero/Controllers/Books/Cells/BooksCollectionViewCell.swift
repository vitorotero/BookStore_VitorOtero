//
//  BooksCollectionViewCell.swift
//  BookStore_VitorOtero
//
//  Created by VitorOtero on 14/12/2019.
//  Copyright © 2019 VitorOtero. All rights reserved.
//

import UIKit
import Kingfisher

class BooksCollectionViewCell: UICollectionViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var bookNameLabel: UILabel!
    
    // MARK: - Properties
    static let identifier = "BooksCollectionViewCell"
    
    // MARK: - Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        mainView.layer.cornerRadius = 5
        thumbnailImageView.kf.indicatorType = .activity
    }
    
    func setup(item: Book) {
        thumbnailImageView.image = "iconBook".imageAsset
        
        if let images = item.volumeInfo?.imageLinks {
            let url = URL(string: images.thumbnail)
            thumbnailImageView.kf.setImage(with: url,
                                           placeholder: "iconBook".imageAsset)
        }
        
        bookNameLabel.text = item.volumeInfo?.title
    }

}
