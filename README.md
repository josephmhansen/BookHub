
## **BookHub**

**Part 1**
-  Start this project by creating a new branch off of **Starting Point V2**

- This project has a base starting point where all the views and constraints have been setup for you so you can spend your time researching and coding.

-	Your goal is to create a library collection of books using a collection view and cloudKit sorted by date added.

- If you know how to use a **Table View** than you know how to use a **Collection View**. Read up on documentation & online resources about **Collection Views** to see the additional cool things they can do.

- The first view (BookListViewController) will display the book cover image of your saved book as well as the rating you gave the book. This BookListCollectionView's items (known as rows in a Table View) will be updated automatically by fetching the most recent collection off of CloudKit.

![booklistview](https://cloud.githubusercontent.com/assets/6709516/17558897/6b08e464-5ed9-11e6-93ad-40f04e280b4f.png)

- In the AddBookViewController you have a button called **Get Book Cover**, use this button's action to open up a safari webpage that takes you directly to a book cover website to download the latest book cover images. A website url has been provided to you in code to grab the images from.
 
![bookdetailview](https://cloud.githubusercontent.com/assets/6709516/17558899/6d04c418-5ed9-11e6-9a0d-fdc6b88e668d.png)

- In the AddBookViewController update the imageView with the book cover, give your book a rating and save it to CloudKit.

-	Use the following code as your starting point for your CloudKitManager:
	
    import UIKit
    import CloudKit
    
    class CloudKitManager {
        
        let database = CKContainer.defaultContainer().publicCloudDatabase
        
        func fetchRecordsWithType(type: String, sortDescriptors: [NSSortDescriptor]? = nil, completion: ([CKRecord]?, NSError?) -> Void) {
            
            let query = CKQuery(recordType: type, predicate: NSPredicate(value: true))
            query.sortDescriptors = sortDescriptors
            
            database.performQuery(query, inZoneWithID: nil, completionHandler: completion)
        }
        
        func saveRecord(record: CKRecord, completion: ((NSError?) -> Void) = {_ in }) {
    
            database.saveRecord(record) { (_, error) in
                completion(error)
            }
        }
    }

- Note that this project is completely CloudKit based/network dependent and does not use local persistence to save your data, all data will be save from the cloud and should automatically populate your collection view upon loading your app every time.



> Written with [StackEdit](https://stackedit.io/).
