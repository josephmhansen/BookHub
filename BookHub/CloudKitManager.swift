//
//  CloudKitManager.swift
//  BookHub
//
//  Created by Diego Aguirre on 8/10/16.
//  Copyright © 2016 home. All rights reserved.
//

import Foundation
import UIKit
import CloudKit

class CloudKitManager {
    
    let database = CKContainer.defaultContainer().publicCloudDatabase
    
    func fetchRecordsWithType(type: String, sortDescriptors: [NSSortDescriptor]? = nil, completion: ([CKRecord]?, NSError?) -> Void) {
        
        let query = CKQuery(recordType: type, predicate: NSPredicate(value: true))
        query.sortDescriptors = sortDescriptors
        
        database.performQuery(query, inZoneWithID: nil, completionHandler: completion)
    }
    
    func saveRecord(record: CKRecord, completion: ((record: CKRecord?, error: NSError?) -> Void)?) {
        
        database.saveRecord(record) { (record, error) in
            
            completion?(record: record, error: error)
        }
    }
}