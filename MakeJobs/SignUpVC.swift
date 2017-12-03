//Make Jobs
//  SignUpVC.swift
//  MakeJobs
//
//  Created by Nikhil on 5/13/17.
//  Copyright © 2017 Nikhil. All rights reserved.
//

import UIKit
import Firebase
import KeychainSwift

class SignUpVC: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passworrdField: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var currentBalance: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
        
        let borderAlpha : CGFloat = 0.7
        signUpButton.backgroundColor = UIColor.clear
        signUpButton.layer.borderWidth = 3.0
        signUpButton.layer.borderColor = UIColor(white: 1.0, alpha: borderAlpha).cgColor

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let keyChain = DataSerivce().keyChain
        if keyChain.get("uid") != nil{
            performSegue(withIdentifier: "SignUp", sender: nil)
        }
    }
    
    func completeSignIn(id: String){
        let key = DataSerivce().keyChain
        key.set(id, forKey: "uid")
    }
    
    func alertCall(title: String, message: String) {
        // create the alert
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        //Add an action aka Button
         alert.addAction(UIAlertAction(title: "Let's Fix It!", style: UIAlertActionStyle.default, handler: nil))
        //Present the alert
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func letsGoPressed(_ sender: Any) {
        
        if (nameField.text != "") && (emailField.text != "") && (passworrdField.text !=  "") && (confirmPassword.text != "") && (currentBalance.text != "") {
            if (confirmPassword.text == passworrdField.text){
                let name = nameField.text
                let email = emailField.text
                let balance = currentBalance.text
                let password = passworrdField.text
                FIRAuth.auth()?.createUser(withEmail: email!, password: password!, completion: { (user, error) in
                    if error != nil {
                        print(error!.localizedDescription)
                        self.alertCall(title: "Invalid", message: "\(error!.localizedDescription)")
                    }else {
                        guard let uid = user?.uid else{
                            return
                        }
                        let values  = ["name" : name, "email" : email, "balance" : balance]
                        self.registerUserIntoDatabaseWithUID(uid: uid, values: values as [String: AnyObject])
                         ////Going to Register User into Database
                    }//End of Else
                })//End of FURAuth
            } else {
                alertCall(title: "Passwords Not Matching", message: "Make sure your password macthes.")
            }
        }else{
            alertCall(title: "Nice Try!", message: "Make sure you fill in all the information")
        }

    }
    
    func registerUserIntoDatabaseWithUID(uid: String, values: [String: AnyObject]) {
        //Saving user in DataBase Name and Email
        let ref = FIRDatabase.database().reference(fromURL: "https://makejobs-f8b21.firebaseio.com/")
        let usersFolder = ref.child("Users").child((uid)) //creates users folder and inside of that creates another folder of users UID
        //        let values = ["name": name, "email": email, "profileImageUrl": metadata.downloadUrl]
        usersFolder.updateChildValues(values, withCompletionBlock: { (err, ref) in //means that update name and email inside the users/UID folder
            if err != nil {
                print(err!)  ///If there is an error
                return
            }
            //User Saved in DB
            print("User Saved in Database")
        })
        //Ends here for that
        self.completeSignIn(id: uid)
        self.dismiss(animated: true, completion: nil)

    }

    
    @IBAction func backPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        self.performSegue(withIdentifier: "back", sender: nil)
    }
    

}
