//
//  Book.swift
//  BookHub
//
//  Created by Diego Aguirre on 8/10/16.
//  Copyright © 2016 home. All rights reserved.
//

import Foundation
import UIKit

struct Book {
    var rating: String
    let date: NSDate
    var photoData: NSData?
    var photo: UIImage? {
        guard let photoData = photoData else { return nil }
        return UIImage(data: photoData)
    }
}