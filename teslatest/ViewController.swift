//
//  ViewController.swift
//  teslatest
//
//  Created by Daniel Trondsen Wallin on 2016-11-14.
//  Copyright © 2016 Daniel Trondsen Wallin. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var date: Date? = nil
    
    // Just testing a little bit
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if PFUser.current() != nil {
            logIn()
        }
        
        self.navigationController?.isNavigationBarHidden = true
        
        
        /*let query = PFQuery(className: "AllCars")
        query.getObjectInBackground(withId: "eQgmJZcxDX", block: {(object, error) in
        
            if error != nil {
                print(error!.localizedDescription)
            }
            else {
                self.date = object!.createdAt!
                print(self.date!)
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZZ"
                let convertedDate = dateFormatter.string(from: self.date!)
                print(convertedDate)
            }
            
        })*/
        
        
        /*let query = PFQuery(className: "Locations")
        query.whereKey("Name", equalTo: "Täby")
        query.getFirstObjectInBackground { (object, error) in
            
            if error != nil {
                print(error!.localizedDescription as Any)
            }
            else {
                object?["Name"] = "Bäby"
                object?.saveInBackground(block: { (success, error) in
                    
                    if error != nil {
                        print(error?.localizedDescription as Any)
                    }
                    else {
                        print("hej")
                    }
                    
                })
            }
            
        }*/
        /*query.findObjectsInBackground { (objects, error) in
            
            if error != nil {
                print(error!.localizedDescription as Any)
            }
            else {
                
                if let returnedObjects = objects {
                    
                    for object in returnedObjects {
                        
                        print(object["Name"])
                        
                    }
                    
                }
                
            }
            
        }*/
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func logIn() {
        performSegue(withIdentifier: "LogIn", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func logInWasPressed(_ sender: Any) {
        
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        PFUser.logInWithUsername(inBackground: email, password: password) { (user, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            else {
                self.emailTextField.text = nil
                self.passwordTextField.text = nil
                self.logIn()
            }
        }
        
    }
    


}

