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
    static var imageDataKey: String { return "ImageData" }
    static var dateKey: String { return "Date" }
    
    init?(ckRecord: CKRecord) {
        guard let timeStamp = ckRecord.creationDate,
            photoAsset = ckRecord[Book.imageDataKey] as? CKAsset,
            rating = ckRecord[Book.ratingKey] as? String
            where ckRecord.recordType == Book.recordType else {
                print("Failable initializer Failed!!!")
                return nil
        }
        
        let photoData = NSData(contentsOfURL: photoAsset.fileURL)
        
        self.init(rating: rating, date: timeStamp, photoData: photoData)
    }
    
    private var temporaryPhotoURL: NSURL {
        
        // Must write to temporary directory to be able to pass image file path url to CKAsset
        
        let temporaryDirectory = NSTemporaryDirectory()
        let temporaryDirectoryURL = NSURL(fileURLWithPath: temporaryDirectory)
        let fileURL = temporaryDirectoryURL.URLByAppendingPathComponent(NSUUID().UUIDString).URLByAppendingPathExtension("jpg")
        
        photoData?.writeToURL(fileURL, atomically: true)
        
        return fileURL
    }
    
    var cloudKitRecord: CKRecord {
        let record = CKRecord(recordType: Book.recordType)
        
        record[Book.dateKey] = date
        record[Book.ratingKey] = rating
        record[Book.imageDataKey] = photoData
        
        return record
    }
}