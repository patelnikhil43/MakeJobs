//
//  TabBarVC.swift
//  MakeJobs
//
//  Created by Nikhil on 5/13/17.
//  Copyright © 2017 Nikhil. All rights reserved.
//

import UIKit

class TabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        let swiftColor = UIColor(red: 60/255, green: 142/255, blue: 163/255, alpha: 1)
         self.tabBar.backgroundColor = swiftColor
        self.tabBar.barTintColor = swiftColor

        
    }

}
