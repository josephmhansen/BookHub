//
//  BookCollectionViewCell.swift
//  BookHub
//
//  Created by Diego Aguirre on 8/9/16.
//  Copyright © 2016 home. All rights reserved.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookRatingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateWithBook(book: Book) {
        bookImageView.image = book.photo
        bookRatingLabel.text = book.rating
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
  
    
}
