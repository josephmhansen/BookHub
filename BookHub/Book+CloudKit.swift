//
//  Book+CloudKit.swift
//  BookHub
//
//  Created by Diego Aguirre on 8/10/16.
//  Copyright © 2016 home. All rights reserved.
//

import Foundation
import UIKit
import CloudKit

extension Book {
    static var recordType: String { return "Book" }
    static var ratingKey: String { return "Rating" }
    static var imageKey: String { return "Image" }
    static var dateKey: String { return "Date" }
    
    init?(ckRecord: CKRecord) {
        guard let rating = ckRecord[Book.ratingKey] as? String,
            image = ckRecord[Book.imageKey] as? NSData,
            date = ckRecord[Book.dateKey] as? NSDate
            where ckRecord.recordType == Book.recordType else {
                print("Failable Init failed")
                return nil
        }
        
        self.init(rating: rating, date: date, photoData: image)
    }
    
    var cloudKitRecord: CKRecord {
        let record = CKRecord(recordType: Book.recordType)
        
        record[Book.ratingKey] = rating
        record[Book.dateKey] = date
        record[Book.imageKey] = photoData
        
        return record
    }
}