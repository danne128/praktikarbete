//
//  LoggedInViewController.swift
//  teslatest
//
//  Created by Daniel Trondsen Wallin on 2016-11-14.
//  Copyright © 2016 Daniel Trondsen Wallin. All rights reserved.
//

import UIKit
import Parse

class LoggedInViewController: UIViewController {
    
    let discount = "GR3F4"
    var daysGetting: [String] = []
    var test1 = ""
    var test2 = ""
    var daysPayedFor: [String] = []
    
    var bookCarID = ""
    var userBookingCarID = ""
    
    var array1: [Date] = []
    var array2: [Date] = []
    
    @IBOutlet weak var titleText: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        
        if PFUser.current() != nil {
            
            if let firstName = PFUser.current()?["FirstName"] as? String, let lastName = PFUser.current()?["LastName"] as? String {
                titleText.title = "\(firstName) \(lastName)"
            }
            
            getLocations()
            
        }
        else {
            _ = self.navigationController?.popToRootViewController(animated: true)
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getLocations() {
        
        /*let query = PFQuery(className: "BookedCars")
        query.whereKey("objectId", equalTo: "FN61TKVdnC")
        query.includeKey("Inventory")
        query.getFirstObjectInBackground { (object, error) in
            
            if error != nil {
                print(error!.localizedDescription as Any)
            }
            else {
                let test = object!["BookedCars"] as! PFObject
                let test2 = test.objectId!
            }
            
        }*/
        
        
        // Hitta rabatt
        /*let query = PFQuery(className: "DayDiscount")
        query.whereKey("Code", equalTo: discount)
        query.getFirstObjectInBackground(block: {(objects, error) in
            
            if error != nil {
                print(error!.localizedDescription as Any)
            }
            else if (objects == nil) {
                
                let newQuery = PFQuery(className: "PriceDiscount")
                newQuery.whereKey("Code", equalTo: self.discount)
                newQuery.getFirstObjectInBackground(block: { (newObjects, newError) in
                    
                    if error != nil {
                        print(newError!.localizedDescription)
                        print("hej")
                    }
                    else if newObjects == nil {
                        print("\nThere is no discount with this code\n")
                        return
                    }
                    else {
                        print("\nYou have \(newObjects!["Discount"]!)% discount")
                    }
                    
                })
                
            }
            else {
                
                print("\nYou have a discount that lets you rent the car for \(objects!["DaysGetting"]!) days but paying for \(objects!["DaysPayedFor"]!) \n")
                
            }
            
        })*/
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    @IBAction func logOutWasPressed(_ sender: Any) {
        PFUser.logOut()
        _ = self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    @IBAction func bokaBilWasClicked(_ sender: Any) {
        
        // Boka bil
        let today = Date()
        let tomorrow = Calendar.current.date(byAdding: .day, value: 6, to: today as Date)
        
        let query = PFQuery(className: "Inventory")
        //query.includeKey("Location")
        query.getFirstObjectInBackground { (object, error) in
            
            if error != nil {
                print(error!.localizedDescription as Any)
            }
            else {
                print(object!.objectId!)
                let newQuery = PFQuery(className: "UpcomingBookings")
                newQuery.findObjectsInBackground { (objects, error) in
                    if error != nil {
                        print("test")
                    }
                    else {
                        if objects!.count > 0 {
                            
                            if let returnedObjects = objects {
                                
                                for object in returnedObjects {
                                    
                                    self.array1.append(object["StartDate"] as! Date)
                                    self.array2.append(object["EndDate"] as! Date)
                                }
                                
                            }
                            
                            //print(self.array1[self.array1.count - 1])
                            //print(self.array2[self.array2.count - 1])
                            
                            
                            for (e1, e2) in zip(self.array1, self.array2) {
                                //print("\(e1) - \(e2)")
                                
                                if today > e1 && tomorrow! < e2 {
                                    print("Start och slut ligger i en annan bokning")
                                }
                                else if today < e1 && (tomorrow! < e2 && tomorrow! > e1) {
                                    print("Slut tiden ligger i en annan bokning")
                                }
                                else if today > e1 && (tomorrow! > e2 && today < e2) {
                                    print("Start tiden ligger i en annan bokning")
                                }
                                else if today < e1 && tomorrow! > e2 {
                                    print("Din bokning ligger över en annan")
                                }
                                else {
                                    //print("Bokningen är okej")
                                    
                                    let saveBooking = PFObject(className: "UpcomingBookings")
                                    saveBooking["StartDate"] = today
                                    saveBooking["EndDate"] = tomorrow
                                    saveBooking["BookedBy"] = PFUser.current()
                                    saveBooking["BookedCars"] = PFObject(withoutDataWithClassName: "Inventory", objectId: object!.objectId!)
                                    //saveBooking["Accessories"] = ["Extra Charger"]
                                    saveBooking["Sum"] = 2395
                                    saveBooking["Discount"] = false
                                    saveBooking["PayNow"] = true
                                    //saveBooking["Price"] = 2395
                                    //saveBooking["Agreement"] = "Yes"
                                    //saveBooking["DriversLicense"] = PFFile(name: "drivers_license.jpg", data: imageDataDriversLicense!)
                                    saveBooking.saveInBackground(block: { (success, error) in
                                        
                                        if error != nil {
                                            print(error!.localizedDescription as Any)
                                        }
                                        else {
                                            
                                            print("Success")
                                            
                                        }
                                        
                                    })
                                }
                            }
                        }
                        else {
                            print("Finns inget här")
                            
                            let saveBooking = PFObject(className: "UpcomingBookings")
                            saveBooking["StartDate"] = today
                            saveBooking["EndDate"] = tomorrow
                            saveBooking["BookedBy"] = PFUser.current()
                            saveBooking["BookedCars"] = PFObject(withoutDataWithClassName: "Inventory", objectId: object!.objectId!)
                            //saveBooking["Accessories"] = ["Extra Charger"]
                            saveBooking["Sum"] = 2395
                            saveBooking["Discount"] = false
                            saveBooking["PayNow"] = true
                            //saveBooking["Price"] = 2395
                            //saveBooking["Agreement"] = "Yes"
                            //saveBooking["DriversLicense"] = PFFile(name: "drivers_license.jpg", data: imageDataDriversLicense!)
                            saveBooking.saveInBackground(block: { (success, error) in
                                
                                if error != nil {
                                    print(error!.localizedDescription as Any)
                                }
                                else {
                                    
                                    print("Success")
                                    
                                }
                                
                            })
                        }
                    }
                }
            }
        }
        
        
        
        
    }
    
    @IBAction func registreraAvbokadBilWasClicked(_ sender: Any) {
        
        /*let query = PFQuery(className: "Inventory")
        query.whereKey("RegNr", equalTo: "DEF 456")
        query.whereKey("Booked", equalTo: true)
        query.includeKey("BookedCars")
        query.includeKey("User")
        query.includeKey("Inventory")
        query.getFirstObjectInBackground { (object, error) in
            
            if error != nil {
                print(error!.localizedDescription as Any)
                print("1")
            }
            else {
                let newQuery = PFQuery(className: "BookedCars")
                //newQuery.includeKey("Inventory")
                newQuery.includeKey("BookedCars")
                newQuery.includeKey("User")
                newQuery.includeKey("Inventory")
                newQuery.whereKey("BookedCars", equalTo: PFObject(withoutDataWithClassName: "Inventory", objectId: "\(object!.objectId!)"))
                newQuery.getFirstObjectInBackground(block: { (newObject, newError) in
                    
                    if newError != nil {
                        print(newError!.localizedDescription as Any)
                        print("2")
                    }
                    else {
                        let user = newObject!["BookedBy"] as! PFObject
                        let userID: String = user.objectId!
                        print(userID)
                        let fromDate: Date = newObject!["StartDate"] as! Date
                        let toDate: Date = newObject!["EndDate"] as! Date
                        
                        newObject?.deleteInBackground(block: { (success, error) in
                            
                            if error != nil {
                                print(error!.localizedDescription as Any)
                                print("3")
                            }
                            else {
                                object?["LatestCustomer"] = PFObject(withoutDataWithClassName: "_User", objectId: userID)
                                object?["ChargeLevel"] = 54
                                object?["FromDate"] = fromDate
                                object?["ToDate"] = toDate
                                object?["LeasedBy"] = PFUser.current()
                                object?["UnLeasedBy"] = PFUser.current()
                                object?["Damages"] = "No"
                                object?["Booked"] = false
                                
                                object?.saveInBackground(block: { (success, error) in
                                    
                                    if error != nil {
                                        print(error!.localizedDescription as Any)
                                        print("4")
                                    }
                                    else {
                                        
                                    
                                        let saveInPrevious = PFObject(className: "PreviousBookings")
                                        saveInPrevious["StartDate"] = fromDate
                                        saveInPrevious["EndDate"] = toDate
                                        saveInPrevious["LatestCustomer"] = PFObject(withoutDataWithClassName: "_User", objectId: userID)
                                        saveInPrevious["Car"] = PFObject(withoutDataWithClassName: "Inventory", objectId: "\(object!.objectId!)")
                                        saveInPrevious["Damages"] = "No"
                                        
                                        saveInPrevious.saveInBackground(block: { (success, error) in
                                            
                                            if error != nil {
                                                print(error!.localizedDescription as Any)
                                            }
                                            else {
                                                print("success")
                                            }
                                            
                                        })
                                    }
                                })
                            }
                        })
                    }
                })
            }
        }*/
        
        
        
        
    }
    
    
    
}



