//
//  FeedVC.swift
//  MakeJobs
//
//  Created by Nikhil on 5/13/17.
//  Copyright © 2017 Nikhil. All rights reserved.
//

import UIKit
import Firebase

class FeedVC: UIViewController,  UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableViewBoard: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
      tableViewBoard.delegate = self
        tableViewBoard.dataSource = self
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    //TableView Starts
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }

}
