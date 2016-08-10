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
    
    func postNewBook(book: Book, completion: (NSError?) -> Void) {
        
        let record = book.cloudKitRecord
        
        cloudKitManager.saveRecord(record) { (error) in
            
            if let error = error {
                print("Error saving \(book) to CloudKit \(error.localizedDescription)")
                return
            }
            self.books.insert(book, atIndex: 0)
            print("Book successfully saved!")
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
            
            self.books = records.flatMap { Book(ckRecord: $0) }
            print("Successfully created Book CKRecord")
        }
    }
}