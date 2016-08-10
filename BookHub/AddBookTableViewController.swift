//
//  AddBookTableViewController.swift
//  BookHub
//
//  Created by Diego Aguirre on 8/10/16.
//  Copyright © 2016 home. All rights reserved.
//

import UIKit

class AddBookTableViewController: UITableViewController {

    @IBOutlet weak var scoreTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        return cell
    }
    
    // MARK: Actions
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        
    }
    
    
    @IBAction func addBookButtonTapped(sender: AnyObject) {
        
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "embedPhotoSelect" {
            
        }
    }
}
