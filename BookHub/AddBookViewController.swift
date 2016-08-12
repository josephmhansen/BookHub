//
//  AddBookViewController.swift
//  BookHub
//
//  Created by Diego Aguirre on 8/10/16.
//  Copyright © 2016 home. All rights reserved.
//

import UIKit
import SafariServices

class AddBookViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var ratingTextField: UITextField!
    @IBOutlet weak var bookCoverImageView: UIImageView!
    
    var image: UIImage?
    
    var book: Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ratingTextField.delegate = self
}
    
    func booksWereUpdated() {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
          self.bookCoverImageView.reloadInputViews()
        })
    }
    
    @IBAction func getBookButtonPressed(sender: AnyObject) {
        guard let url = NSURL(string: "http://bookcoverarchive.com") else { return }
        
        let safariController = SFSafariViewController(URL: url)
        presentViewController(safariController, animated: true, completion: nil)
        
    }
    @IBAction func photoTapped(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        
        imagePicker.delegate = self
        
        let actionSheet = UIAlertController(title: "Pick Cover", message: nil, preferredStyle: .ActionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .Default) { (_) in
            imagePicker.sourceType = .PhotoLibrary
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
        let savedPhotosAlbum = UIAlertAction(title: "Saved Photos", style: .Default) { (_) in
            imagePicker.sourceType = .SavedPhotosAlbum
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
        actionSheet.addAction(cancelAction)
        
        if UIImagePickerController.isSourceTypeAvailable(.SavedPhotosAlbum) {
            actionSheet.addAction(savedPhotosAlbum)
        }
        if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
            actionSheet.addAction(photoLibraryAction)
        }
        
        presentViewController(actionSheet, animated: true, completion: nil)
        
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
        
        bookCoverImageView.image = image
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        return ratingTextField.resignFirstResponder()
    }
    
    func noDataAlert(){
        
        let alertController = UIAlertController(title: "Missing something?", message: "Make sure all fields are complete", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "Ok", style: .Cancel, handler: nil)
        alertController.addAction(okAction)
        presentViewController(alertController, animated: true, completion: nil)
        
        

    }
    @IBAction func addBookButtonPressed(sender: AnyObject) {
        
        guard let rating = ratingTextField.text where rating.characters.count > 0,
            let image  = bookCoverImageView.image else {
                noDataAlert()
                return
        }
        
        ratingTextField.resignFirstResponder()
        
      
        
        BookController.sharedController.postNewBook(rating, image: image, date: NSDate()) { (error) in
            if let error = error {
                print("Error, issue adding book \n Error: \(error)")

            }
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        
        //        let book = Book(photoData: , rating: rating, date: NSDate())
    }
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
