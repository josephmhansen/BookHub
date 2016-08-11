//
//  BookController.swift
//  BookHub
//
//  Created by Diego Aguirre on 8/10/16.
//  Copyright © 2016 home. All rights reserved.
//

import Foundation
import UIKit
import CloudKit

public let BookControllerDidRefreshNotification = "BookControllerDidRefreshNotification"

class BookController {
    
    static let sharedController = BookController()
    private let cloudKitManager = CloudKitManager()
    
    init() {
        refresh()
    }
    
    private(set) var books: [Book] = [] {
        
        didSet {
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                let nc = NSNotificationCenter.defaultCenter()
                nc.postNotificationName(BookControllerDidRefreshNotification, object: self)
            })
        }
    }
    
    func postNewBook(rating: String, image: UIImage, date: NSDate, completion: ((Book) -> Void)?) {
       guard let data = UIImageJPEGRepresentation(image, 0.8) else { return }
        
        let book = Book(rating: rating, timestamp: NSDate(), photoData: data)
        books.append(book)
        
        cloudKitManager.saveRecord(CKRecord(book)) { (record, error) in
            guard let record = record else {
                if let error = error {
                    print("Error saving new book to CloudKit \(error.localizedDescription)")
                    return
                }
                completion?(book)
                return
            }
            book.cloudKitRecordID = record.recordID
        }
       
    }
    
    func refresh(completion: ((NSError?) -> Void)? = nil) {
        
        let sortDescriptors = [NSSortDescriptor(key: Book.dateKey, ascending: false)]
        cloudKitManager.fetchRecordsWithType(Book.recordType, sortDescriptors: sortDescriptors) { (records, error) in
            
            if let error = error {
                print("Error fetching books: \(error.localizedDescription)")
                return
            }
            
            guard let records = records else { return }
            
            self.books = records.flatMap { Book(record: $0) }
            print("Successfully created Book CKRecord")
        }
    }
}