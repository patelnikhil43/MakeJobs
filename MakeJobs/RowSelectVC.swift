//
//  RowSelectVC.swift
//  MakeJobs
//
//  Created by Nikhil on 5/13/17.
//  Copyright © 2017 Nikhil. All rights reserved.
//

import UIKit
import MessageUI

class RowSelectVC: UIViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var labelForTitle: UILabel!
    @IBOutlet weak var labelForDescription: UILabel!
    @IBOutlet weak var labelForCity: UILabel!
    @IBOutlet weak var labelForMiles: UILabel!
    @IBOutlet weak var labelForMoney: UILabel!
    @IBOutlet weak var labelForEmail: UIButton!
    
    @IBOutlet weak var imageView: UIView!
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var moneyView: UIView!
    

    var titleLabel:String?
    var descriptionLabel: String?
    var citystateLabel: String?
    var milesAwayLabel:String?
    var moneyLabel: String?
    var emailLabel: String?
    var phoneLabel: String?
    var imageName: String?
    
    let grayShadow = UIColor(red: 141/255, green: 148/255, blue: 160/255, alpha: 1).cgColor

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Title
        labelForTitle.text  = titleLabel
        labelForDescription.text  = descriptionLabel
        labelForCity.text  = citystateLabel
        labelForMiles.text = "\(milesAwayLabel!) miles away"
        labelForMoney.text = "$\(moneyLabel!) offered for this job"
        labelForEmail.setTitle(emailLabel, for: .normal)
        
        viewBorder(myView: imageView)
        viewBorder(myView: phoneView)
        viewBorder(myView: moneyView)
    }
    
    //View Shadow
    func viewBorder(myView:UIView){
        myView.layer.shadowColor = grayShadow
        myView.layer.shadowOpacity = 1
        myView.layer.shadowOffset = CGSize.zero
        myView.layer.shadowRadius = 10
        myView.layer.shouldRasterize = true
    }
    //End of View Shadow
    
    
//Image
    
    @IBAction func imagePressed(_ sender: Any) {
        performSegue(withIdentifier: "imagePressed", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "imagePressed"){
            let vc = segue.destination as! ImageVC
            vc.passedImageName = imageName
        }
    }
    
//Call
    @IBAction func callButton(_ sender: Any) {
        
                let url:NSURL = URL(string: "tel://\(phoneLabel!)")! as NSURL
                UIApplication.shared.openURL(url as URL)
    }
    
//Email
    
    @IBAction func emailPressed(_ sender: Any) {
        let mailComposer  = configuredMailComposer()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposer, animated: true, completion: nil)
        }else{
            self.showEmailError()
        }
    }
    
    func configuredMailComposer() ->MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients(["\(emailLabel!)"])
        mailComposerVC.setSubject("Make & Get Job Posting")
        mailComposerVC.setMessageBody("Hello, \n\n I saw your post on Make & Get Jobs, I would love to work for you!", isHTML: false)
        return mailComposerVC
    }
    //If error while sending email
    func showEmailError(){
        alertCall(title: "Failed", message: "Sorry, we coudn't send your email. Please try again.")
    }
    
    func alertCall(title: String, message: String) {
        // create the alert
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        //Add an action aka Button
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        //Present the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
        case MFMailComposeResult.cancelled:
            print("Mail Cancelled")
        case MFMailComposeResult.sent:
            print("Mail Sent")
        case MFMailComposeResult.failed:
            print("Failed to send")
        default:
            break
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    //End of Email
    
    @IBAction func dismissButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
 
}
