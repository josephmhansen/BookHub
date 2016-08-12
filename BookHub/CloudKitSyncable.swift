//
//  CloudKitSyncable.swift
//  BookHub
//
//  Created by Joseph Hansen on 8/12/16.
//  Copyright © 2016 home. All rights reserved.
//

import Foundation
import CloudKit
import CoreData

protocol CloudKitSyncable {
    var timestamp: NSDate { get set }
    var recordIDData: NSData? { get set }
    var recordName: String { get set }
    var recordType: String { get }
    
    var cloudKitRecordID: CKRecordID? { get }
    
    init?(record: CKRecord, context: NSManagedObjectContext)
}

extension CloudKitSyncable {
    var isSynced: Bool {
        return recordIDData != nil
    }
    
    var cloudKitRecordID: CKRecordID? {
        guard let recordIDData = recordIDData,
            let recordID = NSKeyedUnarchiver.unarchiveObjectWithData(recordIDData) as? CKRecordID else { return nil }
        
        return recordID
    }
    
    var cloudKitReference: CKReference? {
        
        guard let recordID = cloudKitRecordID else { return nil }
        
        return CKReference(recordID: recordID, action: .None)
    }
    
}


