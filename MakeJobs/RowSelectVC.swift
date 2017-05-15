//
//  RowSelectVC.swift
//  MakeJobs
//
//  Created by Nikhil on 5/13/17.
//  Copyright © 2017 Nikhil. All rights reserved.
//

import UIKit

class RowSelectVC: UIViewController {

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
    
    let grayShadow = UIColor(red: 141/255, green: 148/255, blue: 160/255, alpha: 1).cgColor

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Title
        labelForTitle.text  = titleLabel
        labelForDescription.text  = descriptionLabel
        labelForCity.text  = citystateLabel
        labelForMiles.text = "\(milesAwayLabel!) miles away"
        labelForMoney.text = moneyLabel
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
    
//    @IBAction func callButton(_ sender: Any) {
//        
//        let url:NSURL = URL(string: "tel://1234567891")! as NSURL
//        UIApplication.shared.openURL(url as URL)
//
//    }
    
    @IBAction func dismissButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
 
}
