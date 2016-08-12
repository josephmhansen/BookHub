//
//  BookController.swift
//  BookHub
//
//  Created by Joseph Hansen on 8/11/16.
//  Copyright © 2016 home. All rights reserved.
//

import Foundation
import UIKit

public let BookControllerDidRefreshNotification = "BookControllerDidRefreshNotification"

class BookController {
    static var sharedController = BookController()
    private let cloudKitManager = CloudKitManager()
    
    
    init(){
        fetchBooks()
    }
    
    private(set) var books: [Book] = [] {
        didSet{
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                let nc = NSNotificationCenter.defaultCenter()
                nc.postNotificationName(BookControllerDidRefreshNotification, object: self)
            })
        }
    }
    
    func fetchBooks(completion: ((NSError?) -> Void)? = nil) {
        let sortDescriptors = [NSSortDescriptor(key: Book.dateKey, ascending: false)]
        
        cloudKitManager.fetchRecordsWithType(Book.recordType, sortDescriptors: sortDescriptors) { (records, error) in
            defer {
                completion?(error)
            }
            
            if let error = error {
                print("Error fetching messages: \(error.localizedDescription)")
                return
            }
            guard let records = records else {
                print("Error no record Found")
                return
            }
            self.books = records.flatMap { Book(cloudKitRecord: $0) }
            print("Successfully fetched Books from CKRecords")
        }
        
        
    }
    
    func postNewBook(rating: String, image: UIImage, date: NSDate, completion: ((NSError?) -> Void)) {
        guard let data = UIImageJPEGRepresentation(image, 0.7) else { return }
        
        let book = Book(photoData: data, rating: rating, date: NSDate())
        books.insert(book, atIndex: 0)
        
        cloudKitManager.saveRecord(book.cloudKitRecord) { (error) in
            defer { completion(error) }
            if let error = error {
                print("error, unable to save \(book) to cloudkit \(error.localizedDescription)")
                return
            }
            
//            self.books.insert(book, atIndex: 0)
            print("book saved successfully")
        }
            
        }
        
        
    }



