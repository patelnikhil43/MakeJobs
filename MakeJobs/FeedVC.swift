//
//  FeedVC.swift
//  MakeJobs
//
//  Created by Nikhil on 5/13/17.
//  Copyright © 2017 Nikhil. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation

class FeedVC: UIViewController,  UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {


    @IBOutlet weak var tableViewBoard: UITableView!
    
    //Number of Posts in Array
    var posts = NSMutableArray()
    
    override func viewWillAppear(_ animated: Bool) {
        tableViewBoard.delegate = self
        tableViewBoard.dataSource = self
        posts.removeAllObjects()
        loadData()
        
        //Get current Location
        determineMyCurrentLocation()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        let firebaseAuth = FIRAuth.auth()
//        do{
//            try firebaseAuth?.signOut()
//        } catch let signOutError as NSError{
//            print("Sign Out error: %@", signOutError )
//        }
//        DataSerivce().keyChain.delete("uid")
//        dismiss(animated: true, completion: nil)
    }

    //Location
    var locationManager: CLLocationManager!

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
    
    var Currentlatitude:Double?
    var Currentlongitude: Double?
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        manager.stopUpdatingLocation()
        Currentlatitude  = userLocation.coordinate.latitude
        Currentlongitude = userLocation.coordinate.longitude
    }
    //If there is an error while updating location
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error.localizedDescription)")
    }
    
    //End of Location
    
    //Loads The Posts from Firebase
    func loadData(){
        FIRDatabase.database().reference().child("Posts").observeSingleEvent(of: .value, with: { (snapshot) in
            print(snapshot)
            if let postDictionary = snapshot.value as? [String: AnyObject]{
                for post in postDictionary {
                    self.posts.add(post.value)                    // Basically adds all the values in snapshot to array posts using for loop
                }
                
                self.tableViewBoard.reloadData()
            }//End of postDictionary
        })//End of FireBase Database
    }//End of LoadData Function
    
    
    
    //TableView Starts
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.posts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "postcell", for: indexPath) as! FeedCell
          let post = self.posts[indexPath.row] as! [String: AnyObject]
        
        cell.descriptionLabel.text = post["description"] as? String
        cell.title.text = post["title"] as? String
        cell.cityLabel.text = post["city"] as? String
        
        if (Currentlatitude != nil) && (Currentlongitude != nil ){
        //Distance
         let  currentUserCoordinate = CLLocation(latitude: Currentlatitude!, longitude: Currentlongitude!)
         let otherUserCoordinate = CLLocation(latitude: Double((post["latitude"] as? String)!)!, longitude: Double((post["longitude"] as? String)!)!)
         let distanceInMeters  = currentUserCoordinate.distance(from: otherUserCoordinate)
       let miles  = String(format: "%.2f", distanceInMeters * 0.000621371)
        
        cell.milesAwayLabel.text  = "\(miles) Miles Away"
            someMiles.append("\(miles)")
        //End of Distance
        } else{
            determineMyCurrentLocation()
        }
        //Color
         let swiftColor = UIColor(red: 91/255, green: 182/255, blue: 183/255, alpha: 1)
        let swiftColor2  = UIColor(red: 94/255, green: 126/255, blue: 168/255, alpha: 1)
        if ( indexPath.row % 2 == 0 ){
        cell.backgroundColor = swiftColor
        }
        else{
        cell.backgroundColor = swiftColor2
        }
        //End of Color

        
        return cell
    }
    
    //Did Select Row 
    var postTitle: String?
    var postDescription: String?
    var postCity: String?
    var postMiles: String?
    var postMoney: String?
    var postEmail: String?
    var someMiles = [String]()
    var postPhone: String?
    var postImageName: String?
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        
        let post = self.posts[indexPath.row] as! [String: AnyObject]

        postTitle = post["title"] as? String
        postDescription = post["description"] as? String
        postCity = post["city"] as? String
        postMiles = someMiles[indexPath.row]
        postMoney = post["money"] as? String
        postEmail = post["email"] as? String
        postPhone = post["phone"] as? String
        postImageName = post["image"] as? String
        performSegue(withIdentifier: "rowClicked", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "rowClicked"){
            let vc = segue.destination as! RowSelectVC
            print(postTitle!)
            vc.titleLabel = postTitle
            vc.descriptionLabel = postDescription
            vc.citystateLabel = postCity
            vc.milesAwayLabel = postMiles
            vc.moneyLabel = postMoney
            vc.emailLabel = postEmail
            vc.phoneLabel = postPhone
            vc.imageName = postImageName
        }
        
    }

}
