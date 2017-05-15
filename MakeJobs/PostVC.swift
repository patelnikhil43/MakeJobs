//
//  PostVC.swift
//  MakeJobs
//
//  Created by Nikhil on 5/13/17.
//  Copyright © 2017 Nikhil. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation
class PostVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate,  UITextFieldDelegate  {

    @IBOutlet weak var jobTitleField: UITextField!
    @IBOutlet weak var descriptionField: UITextView!
    @IBOutlet weak var uploadImageButton: UIButton!
    @IBOutlet weak var cityStateField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var dollarField: UITextField!
    @IBOutlet weak var differentImage: UIButton!
    @IBOutlet weak var postButton: UIButton!
    
    //Location
    var locationManager: CLLocationManager!
    
    //Asks for Location & If Location Access Given Then sets the Location of the User into Firebase
    func determineMyCurrentLocation(){
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        //If The Location Is enabled Then it asks for location
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            //locationManager.startUpdatingHeading()
        }else{
            locationManager.requestAlwaysAuthorization()
        }
    }
    
    var latitude:Double?
    var longitude: Double?
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        manager.stopUpdatingLocation()
        latitude  = userLocation.coordinate.latitude
        longitude = userLocation.coordinate.longitude
    }
    
    //If there is an error while updating location
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error.localizedDescription)")
    }
    
    
    //End of Location
    
    override func viewDidLoad() {
        super.viewDidLoad()
        differentImage.isHidden = true
        // Do any additional setup after loading the view.
        determineMyCurrentLocation()
        self.hideKeyboardWhenTappedAround()
        
        let borderAlpha : CGFloat = 0.7
        postButton.backgroundColor = UIColor.clear
        postButton.layer.borderWidth = 1.0
        postButton.layer.borderColor = UIColor(white: 1.0, alpha: borderAlpha).cgColor
        
        phoneField.delegate = self
    }
    
    //Post Button Pressed
     var imageFileName = ""
    @IBAction func postButtonPressed(_ sender: Any) {
        if selectedPicture.image != nil {
            if  (FIRAuth.auth()?.currentUser?.uid) != nil {
                if descriptionField.text != nil {
                    uploadImageAndDetails(image: selectedPicture.image!)
                }
            }
        }
    }
    
    func uploadImageAndDetails(image: UIImage){
        let randomName  = randomStringWIthLength(length: 10) //Creating Random Image Name
        let imageData  = UIImageJPEGRepresentation(image, 0.6) //Saving the image as JPEG
          let uploadRef  = FIRStorage.storage().reference().child("PostedImages/\(randomName).jpg") //Storage Reference
        
        uploadRef.put(imageData!, metadata: nil){metadata, error in
            if error == nil {
                    let uid = FIRAuth.auth()?.currentUser?.uid
                 FIRDatabase.database().reference().child("Users").child("\(uid!)").observeSingleEvent(of: .value, with: { (snapshot) in
                    print(snapshot)
                    
                    //Getting All the SnapShot Details into Dictionary
                    if let dicionary = snapshot.value as? [String: AnyObject] {
                        
                        //Setting the user's name to let name
                        let name = dicionary["name"] as! String?
                        let email = dicionary["email"] as! String?
                        print("Image In Process Of Uploading")
                        self.imageFileName = "\(randomName as String).jpg"
                        print("Image FileName is SET to some Random String")
                        print(self.imageFileName)
                        print(name)
                        print(email)
                         print("In The Process of Setting name, uid, description text, and imageName")
                        if (name != nil) && (email != nil) {
                            print("Name & Email")
                            if let uid  = (FIRAuth.auth()?.currentUser?.uid){
                                print("Uid ")
                                if let title = self.jobTitleField.text{
                                    print("title")
                                    if let description = self.descriptionField.text{
                                        print("description")
                                        if let cityState = self.cityStateField.text {
                                            print("city")
                                            if let phone = self.phoneField.text {
                                                print("phone")
                                                if let money = self.dollarField.text{
                                                    print("Money")
                                                    if self.imageFileName != "" {
                                                        print("image name")
                                                        if (self.latitude != nil) && (self.longitude != nil){
                                                            print("longitude and latitude exist")
                                                        let postObject: Dictionary<String, Any> = [
                                                        "title" : title,
                                                        "uid" : uid,
                                                        "description" : description,
                                                        "city" : cityState,
                                                        "phone": phone,
                                                        "money": money,
                                                        "image" : self.imageFileName,
                                                        "latitude": String(describing: self.latitude!),
                                                        "longitude": String(describing: self.longitude!),
                                                        "email" : email!
                                                        ]
                                                         //This Line sets all these values into "Posts" Folder by generating an automatic string
                                                        FIRDatabase.database().reference().child("Posts").childByAutoId().setValue(postObject)
                                                        print("Uploaded to Database")
                                                        
                                                        self.alertCall(title: "Posted!", message: "You offer has been posted.")
                                                        
                                                        self.jobTitleField.text = ""
                                                        self.descriptionField.text = ""
                                                        self.uploadImageButton.isHidden = false
                                                        self.differentImage.isHidden = true
                                                        self.cityStateField.text  = ""
                                                        self.phoneField.text  = ""
                                                        self.dollarField.text = ""
                                                        }//End of Checking longitude and latitude
                                                        }// End of Checking image name Exist
                                                }//End of checking Money Field
                                            }//End of Checking Phone Field
                                        }//End of Checking City Field
                                    }//End of Checking Desciption Field
                                }//End of Checking if title Exits
                            }//End of Checking if UID Exist
                            
                        }// End of Checking if name and email exist

                    }//End of dicionary
                    
                 })// End of Firbase Database
                
            }//End of if error == nil
            else{
                     print("Error Upload Image: \(String(describing: error?.localizedDescription))")
            }
        }//End of uploadRef
    }

    //Alert Box
    func alertCall(title: String, message: String) {
        // create the alert
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        //Add an action aka Button
        alert.addAction(UIAlertAction(title: "Alright!", style: UIAlertActionStyle.default, handler: nil))
        //Present the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    
    //Image Picking

    @IBOutlet weak var selectedPicture: UIImageView!
    
    @IBAction func pickdifferentImage(_ sender: Any) {
        handleSelectProfileImageView()
    }
    
    @IBAction func pickAnImage(_ sender: Any) {
        handleSelectProfileImageView()
    }
    
    //Displays the image picker
    func handleSelectProfileImageView(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print(info)
        //Selected Image
        var selectedImageFromPicker: UIImage?
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            selectedImageFromPicker = editedImage
        }
        else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImageFromPicker = originalImage
        }
        if let selectedImage = selectedImageFromPicker {
            selectedPicture.image = selectedImage
            uploadImageButton.isHidden = true
            differentImage.isHidden = false
        }
        //End-Selected Image
        dismiss(animated: true, completion: nil)
    }
    
    //If there is an error in image picking
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("cancelled")
        dismiss(animated: true, completion: nil)
    }
    
    //Random String Generator
    func randomStringWIthLength(length: Int) -> NSString{
        let characters: NSString =
        "abcdefghijklmnopqrstUvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let randomString: NSMutableString = NSMutableString(capacity: length)
        
        for _ in 0 ..< length {
            let len = UInt32(characters.length)
            let rand = arc4random_uniform(len)
            randomString.appendFormat("%C", characters.character(at: Int(rand)))
        }
        return randomString
    }


    
    //Max Length for Phone Field
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let limitLength:Int = 10
        guard let text = textField.text else { return true }
        let newLength = text.characters.count + string.characters.count - range.length
        return newLength <= limitLength
    }

}
