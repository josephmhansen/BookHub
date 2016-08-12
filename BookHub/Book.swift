//
//  Book.swift
//  BookHub
//
//  Created by Joseph Hansen on 8/11/16.
//  Copyright © 2016 home. All rights reserved.
//

import Foundation
import UIKit

class Book {
    
    static var books: [Book] = []
    
    let photoData: NSData?
    let rating: String?
    let date: NSDate
    
    var photo: UIImage? {
        guard let photoData = self.photoData else { return nil }
        return UIImage(data: photoData)
    }
    
    init(photoData: NSData?, rating: String?, date: NSDate) {
        self.photoData = photoData
        self.rating = rating
        self.date = NSDate()
        
    }
}
