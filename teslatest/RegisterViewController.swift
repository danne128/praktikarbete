//
//  RegisterViewController.swift
//  teslatest
//
//  Created by Daniel Trondsen Wallin on 2016-11-14.
//  Copyright © 2016 Daniel Trondsen Wallin. All rights reserved.
//

import UIKit
import Parse

class RegisterViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var firstNameTextfield: UITextField!
    @IBOutlet weak var lastNameTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var socialSecurityTextfield: UITextField!
    @IBOutlet weak var adressTextField: UITextField!
    @IBOutlet weak var zipCodeTextfield: UITextField!
    
    @IBOutlet weak var countyTextfield: UITextField!
    @IBOutlet weak var phoneNumberTextfield: UITextField!
    
    @IBOutlet weak var driversLicenseImageView: UIImageView!
    @IBOutlet weak var creditCard1FrontImageView: UIImageView!
    @IBOutlet weak var creditCard1BackImageView: UIImageView!
    @IBOutlet weak var creditCard2FrontImageView: UIImageView!
    @IBOutlet weak var creditCard2BackImageView: UIImageView!
    
    @IBOutlet weak var driversLicenseButton: UIButton!
    @IBOutlet weak var creditCard1FrontButton: UIButton!
    @IBOutlet weak var creditCard1BackButton: UIButton!
    @IBOutlet weak var creditCard2FrontButton: UIButton!
    @IBOutlet weak var creditCard2BackButton: UIButton!
    
    var driversLicenseChooser: Bool = false
    var creditCard1FrontChooser: Bool = false
    var creditCard1BackChooser: Bool = false
    var creditCard2FrontChooser: Bool = false
    var creditCard2BackChooser: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        PFUser.registerSubclass()
        
        driversLicenseChooser = false
        creditCard1FrontChooser = false
        creditCard1BackChooser = false
        creditCard2FrontChooser = false
        creditCard2BackChooser = false
        
        /*if driversLicenseImageView.image == nil {
            driversLicenseButton.setTitle("Test", for: .normal)
        }*/

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func driversLicenseButtonWasClicked(_ sender: Any) {
        self.driversLicenseChooser = true
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
            
        }
        
    }
    
    @IBAction func creditCard1FrontWasClicked(_ sender: Any) {
        self.creditCard1FrontChooser = true
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
            
        }
    }
    
    @IBAction func creditCard1BackWasClicked(_ sender: Any) {
        self.creditCard1BackChooser = true
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
            
        }
    }
    
    @IBAction func creditCard2FrontWasClicked(_ sender: Any) {
        self.creditCard2FrontChooser = true
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
            
        }
    }
    
    @IBAction func creditCard2BackWasClicked(_ sender: Any) {
        self.creditCard2BackChooser = true
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
            
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        if self.driversLicenseChooser == true {
            driversLicenseImageView.image = image
            self.dismiss(animated: true, completion: nil)
            driversLicenseChooser = false
        }
        else if self.creditCard1FrontChooser == true {
            creditCard1FrontImageView.image = image
            self.dismiss(animated: true, completion: nil)
            creditCard1FrontChooser = false
        }
        else if self.creditCard1BackChooser == true {
            creditCard1BackImageView.image = image
            self.dismiss(animated: true, completion: nil)
            creditCard1BackChooser = false
        }
        else if self.creditCard2FrontChooser == true {
            creditCard2FrontImageView.image = image
            self.dismiss(animated: true, completion: nil)
            creditCard2FrontChooser = false
        }
        else if self.creditCard2BackChooser == true {
            creditCard2BackImageView.image = image
            self.dismiss(animated: true, completion: nil)
            creditCard2BackChooser = false
        }
        
    }
    
    
    @IBAction func registerWasClicked(_ sender: Any) {
        
        let newUser = PFUser()
        
        if (emailTextfield.text?.isEmpty)! {
            print("du glömde mail")
        }
        else if firstNameTextfield.text!.isEmpty {
            print("du glömde förnamn")
        }
        else if lastNameTextfield.text!.isEmpty {
            print("du glömde efternamn")
        }
        else if passwordTextfield.text!.isEmpty {
            print("du glömde password")
        }
        else if countyTextfield.text!.isEmpty {
            print("Du glömde ort")
        }
        else if adressTextField.text!.isEmpty {
            print("Du glömde adress")
        }
        else if zipCodeTextfield.text!.isEmpty {
            print("Du glömde postnr")
        }
        else if phoneNumberTextfield.text!.isEmpty {
            print("du glömde telefonnummer")
        }
        else if socialSecurityTextfield.text!.isEmpty {
            print("Du glömde personnummer")
        }
        else if driversLicenseImageView.image == nil {
            print("Du glömde körtkortsbild")
        }
        else if creditCard1FrontImageView.image == nil {
            print("Du glömde bild på kreditkort 1 framsida")
        }
        else if creditCard1BackImageView.image == nil {
            print("Du glömde bild på kreditkort 1 baksida")
        }
        else if creditCard2FrontImageView.image == nil {
            print("Du glömde bild på kreditkort 2 framsida")
        }
        else if creditCard2BackImageView.image == nil {
            print("Du glömde bild på kreditkort 2 baksida")
        }
        else {
            newUser.email = emailTextfield.text
            newUser.password = passwordTextfield.text
            newUser.username = emailTextfield.text
            newUser["FirstName"] = firstNameTextfield.text
            newUser["LastName"] = lastNameTextfield.text
            newUser["PhoneNumber"] = phoneNumberTextfield.text
            newUser["Adress"] = adressTextField.text
            newUser["ZipCode"] = zipCodeTextfield.text
            newUser["County"] = countyTextfield.text
            newUser["SocialSecurity"] = socialSecurityTextfield.text
            
            let imageDataDriversLicense = UIImagePNGRepresentation(self.driversLicenseImageView.image!)
            let imageDataCreditCard1Front = UIImagePNGRepresentation(self.creditCard1FrontImageView.image!)
            let imageDataCreditCard1Back = UIImagePNGRepresentation(self.creditCard1BackImageView.image!)
            let imageDataCreditCard2Front = UIImagePNGRepresentation(self.creditCard2FrontImageView.image!)
            let imageDataCreditCard2Back = UIImagePNGRepresentation(self.creditCard2BackImageView.image!)
            
            newUser["DriversLicense"] = PFFile(name: "drivers_license.jpg", data: imageDataDriversLicense!)
            newUser["CreditCard1Front"] = PFFile(name: "creditcard_1_front.jpg", data: imageDataCreditCard1Front!)
            newUser["CreditCard1Back"] = PFFile(name: "creditcard_1_back.jpg", data: imageDataCreditCard1Back!)
            newUser["CreditCard2Front"] = PFFile(name: "creditcard_2_front.jpg", data: imageDataCreditCard2Front!)
            newUser["CreditCard2Back"] = PFFile(name: "creditcard_2_back.jpg", data: imageDataCreditCard2Back!)
            
            newUser.signUpInBackground(block: { (success, error) in
                
                if error != nil {
                    print(error!.localizedDescription)
                }
                else {
                    print("User has been saved")
                    self.logIn()
                }
                
            })
            
        }
    }
    
    
    func logIn() {
        performSegue(withIdentifier: "JumpToLoggedIn", sender: self)
    }
    

}
