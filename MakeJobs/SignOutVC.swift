//
//  SignOutVC.swift
//  MakeJobs
//
//  Created by Nikhil on 5/15/17.
//  Copyright © 2017 Nikhil. All rights reserved.
//

import UIKit
import Firebase
class SignOutVC: UIViewController {

    

    override func viewDidLoad() {
        super.viewDidLoad()
                let firebaseAuth = FIRAuth.auth()
                do{
                    try firebaseAuth?.signOut()
                } catch let signOutError as NSError{
                    print("Sign Out error: %@", signOutError )
                }
                DataSerivce().keyChain.delete("uid")
                dismiss(animated: true, completion: nil)
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

}
