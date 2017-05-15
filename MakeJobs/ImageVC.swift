//
//  ImageVC.swift
//  MakeJobs
//
//  Created by Nikhil on 5/15/17.
//  Copyright © 2017 Nikhil. All rights reserved.
//

import UIKit

class ImageVC: UIViewController {

    @IBOutlet weak var postedImageView: UIImageView!
    
    var passedImageName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postedImageView.loadImageUsingFirebaseStrorage(imageName: passedImageName!)
        // Do any additional setup after loading the view.
    }

    @IBAction func closePressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }


}
