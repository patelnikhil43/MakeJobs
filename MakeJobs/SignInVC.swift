//
//  ViewController.swift
//  MakeJobs
//
//  Created by Nikhil on 5/12/17.
//  Copyright © 2017 Nikhil. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import KeychainSwift


class SignInVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signupButton: Bounce!
    
    override func viewDidAppear(_ animated: Bool) {
        let keyChain = DataSerivce().keyChain
        if keyChain.get("uid") != nil{
            let user  = User()
            user.uid = keyChain.get("uid")
            print("This is the uid of the user \(user.uid!)")
            performSegue(withIdentifier: "loginSuccess", sender: nil)
        }
      
    }
    
    
    
    func completeSignIn(id: String){
        let key = DataSerivce().keyChain
        key.set(id, forKey: "uid")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.hideKeyboardWhenTappedAround()
        passwordField.delegate = self
        emailField.delegate = self
        
        let borderAlpha : CGFloat = 0.7
        signupButton.backgroundColor = UIColor.clear
        signupButton.layer.borderWidth = 3.0
        signupButton.layer.borderColor = UIColor(white: 1.0, alpha: borderAlpha).cgColor

        UIApplication.shared.isStatusBarHidden = false
    }

    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()  //if desired
        performAction()
        return true
    }
    
    
    @IBAction func signInPressed(_ sender: Any) {
        performAction()
           }
 
    func performAction(){
     if let email = emailField.text , let password = passwordField.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                if error == nil {               //if there is no error
                    self.completeSignIn(id: user!.uid)
                    print("Signed IN")
                    self.emailField.text = ""
                    self.passwordField.text = ""
                    self.performSegue(withIdentifier: "loginSuccess", sender: nil)
                }else{
                    print(error!.localizedDescription)
                    self.alertCall(title: "Invalid Credentials", message: "\(error!.localizedDescription)")
                }//End of else
            }) // End of Firbase Auth
        }//End of if check for email & pass
    }//End of Perform Action function
    
    func alertCall(title: String, message: String) {
        // create the alert
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        //Add an action aka Button
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        //Present the alert
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func signUpPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "signUpPressed", sender: nil)
    }

}

