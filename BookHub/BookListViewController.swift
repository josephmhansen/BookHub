//
//  BookListViewController.swift
//  BookHub
//
//  Created by Diego Aguirre on 8/9/16.
//  Copyright © 2016 home. All rights reserved.
//

import UIKit

class BookListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    

    override func viewDidLoad() {
       
        super.viewDidLoad()
        let nc = NSNotificationCenter.defaultCenter()
        nc.addObserver(self, selector: #selector(booksWereUpdated), name: BookControllerDidRefreshNotification, object: nil)
        
    }
    
    func booksWereUpdated() {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.collectionView.reloadData()
        })
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(BookController.sharedController.books.count)
        return BookController.sharedController.books.count
    }
    
    let dateFormatter: NSDateFormatter = {
        let formatter = NSDateFormatter()
        formatter.dateStyle = .ShortStyle
        formatter.doesRelativeDateFormatting = true
        formatter.timeStyle = .ShortStyle
        
        return formatter
    }()
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCellWithReuseIdentifier("bookItem", forIndexPath: indexPath) as? BookCollectionViewCell else { return UICollectionViewCell() }
        let book = BookController.sharedController.books[indexPath.row]
        cell.updateWithBook(book)
        
        
        return cell
    }
        
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       
    }
}
