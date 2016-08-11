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
    
    @IBAction func imageTapped(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        
        imagePicker.delegate = self
        
        let actionSheet = UIAlertController(title: "Choose a Book Cover", message: nil, preferredStyle: .ActionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .Default) { (_) in
            imagePicker.sourceType = .PhotoLibrary
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
        
        let savedPhotosAction = UIAlertAction(title: "Saved Photos", style: .Default) { (_) in
            imagePicker.sourceType = .SavedPhotosAlbum
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
        
        actionSheet.addAction(cancelAction)
        
        if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
            actionSheet.addAction(photoLibraryAction)
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.SavedPhotosAlbum) {
            actionSheet.addAction(savedPhotosAction)
        }
        
        presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
        
        bookCoverImageView.image = image
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func getBookButtonPressed(sender: AnyObject) {
        // Use the following URL to get book covers
        guard let url = NSURL(string: "http://bookcoverarchive.com") else { return }
        
        let safariController = SFSafariViewController(URL: url)
        presentViewController(safariController, animated: true, completion: nil)
    }
    
    @IBAction func addBookButtonPressed(sender: AnyObject) {
        guard let ratingText = ratingTextField.text,
            image = bookCoverImageView.image else {
                print("No Rating or Image to add to a book")
                return
        }
            
            // let book = Book(rating: ratingText, timestamp: NSDate(), photoData: photoData)
            BookController.sharedController.postNewBook(ratingText, image: image, date: NSDate(), completion: nil)
            self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        return ratingTextField.resignFirstResponder()
    }
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
