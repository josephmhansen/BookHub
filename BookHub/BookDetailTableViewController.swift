//
//  BookDetailTableViewController.swift
//  BookHub
//
//  Created by Diego Aguirre on 8/9/16.
//  Copyright © 2016 home. All rights reserved.
//

import UIKit

class BookDetailTableViewController: UITableViewController {

    @IBOutlet weak var ratingButtonItem: UIBarButtonItem!
    @IBOutlet weak var bookCoverImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("commentCell", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    
    // MARK: Actions
    
    @IBAction func commentButtonPressed(sender: AnyObject) {
        
    }
    
    @IBAction func shareButtonPressed(sender: AnyObject) {
        
    }
}
