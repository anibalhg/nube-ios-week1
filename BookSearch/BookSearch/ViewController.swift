//
//  ViewController.swift
//  BookSearch
//
//  Created by Dev on 11/25/15.
//  Copyright © 2015 Dev. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var txtISBN: UITextField!
    @IBOutlet weak var txtData: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtISBN.delegate = self
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if let isbn = textField.text {
            
            let urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:\(isbn)"
            let url = NSURL(string: urls)!
            let session = NSURLSession.sharedSession()

            let task = session.dataTaskWithURL(url, completionHandler: {data, response, error in
                dispatch_async(dispatch_get_main_queue(), {
                    if error != nil {
                        self.txtData.text = error!.localizedDescription
                    }
                    else if data == nil {
                        self.txtData.text = "No se encontraron datos"
                    }
                    else {
                        let text = NSString(data: data!, encoding: NSUTF8StringEncoding)!
                        self.txtData.text = text as String
                    }
                    textField.resignFirstResponder()
                })
            })
            task.resume()
            return true
        }
        else {
            self.txtData.text = "Debe introducir una ISBN"
            return false
        }
    }

}

