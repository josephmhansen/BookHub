//
//  AddBookViewController.swift
//  BookHub
//
//  Created by Diego Aguirre on 8/10/16.
//  Copyright © 2016 home. All rights reserved.
//

import UIKit

class AddBookViewController: UIViewController {
    
    @IBOutlet weak var ratingTextField: UITextField!
    @IBOutlet weak var bookCoverImageView: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func getBookButtonPressed(sender: AnyObject) {
        // Use the following URL to get book covers 
        guard let url = NSURL(string: "http://bookcoverarchive.com") else { return }
    }
   
    @IBAction func addBookButtonPressed(sender: AnyObject) {
        
    }
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        
    }
    
}
