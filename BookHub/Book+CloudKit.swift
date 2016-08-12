//
//  Book+CloudKit.swift
//  BookHub
//
//  Created by Joseph Hansen on 8/11/16.
//  Copyright © 2016 home. All rights reserved.
//

import Foundation
import UIKit
import CloudKit

extension Book {
    static var recordType: String { return "Book" }
    static var bookImageKey: String { return "Image" }
    static var ratingKey: String { return "Rating" }
    static var dateKey: String { return "Date" }
    
    convenience init?(cloudKitRecord: CKRecord) {
        guard let image = cloudKitRecord[Book.bookImageKey] as? NSData,
        rating = cloudKitRecord[Book.ratingKey] as? String,
        date = cloudKitRecord[Book.dateKey] as? NSDate
        where cloudKitRecord.recordType == Book.recordType else {
        print("Error: CKRecord failable initializer failed")
            return nil
        }
        
        self.init(photoData: image, rating: rating, date: date)
    }
    
    var cloudKitRecord: CKRecord {
        let record = CKRecord(recordType: Book.recordType)
        record[Book.bookImageKey] = photoData
        record[Book.ratingKey] = rating
        record[Book.dateKey] = date
        return record
    }
}
