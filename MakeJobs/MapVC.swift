//
//  MapVC.swift
//  MakeJobs
//
//  Created by Nikhil on 5/15/17.
//  Copyright © 2017 Nikhil. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Firebase

class MapVC: UIViewController, MKMapViewDelegate {

    
    @IBOutlet weak var map: MKMapView!

//    var currentLatitude: Double?
//    var currentLongitude: Double?
     override func viewWillAppear(_ animated: Bool) {
        self.retrievePosts()
        map.isZoomEnabled = true
   
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        map.delegate = self
  
       
     

    }
    


        func retrievePosts(){
            FIRDatabase.database().reference().child("Posts").observe(.childAdded, with: { (snapshot) in
                print(snapshot)
                
              if let dictionary  = snapshot.value as? [String: AnyObject]{
                
                let point  = StarbucksAnnotation(coordinate: CLLocationCoordinate2D(latitude: Double((dictionary["latitude"] as? String)!)!, longitude: Double((dictionary["longitude"] as? String)!)!))
                point.descriptionFor = dictionary["description"] as? String
                point.image = UIImage(named: "starbucks")
                point.phone = dictionary["phone"] as? String
                point.name = dictionary["title"] as? String
                point.imageName = dictionary["image"] as? String
                self.map.addAnnotation(point)
                }
            
                
            }, withCancel: nil)
        }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation
        {
            return nil
        }
        var annotationView = self.map.dequeueReusableAnnotationView(withIdentifier: "Pin")
        if annotationView == nil{
            annotationView = AnnotationView(annotation: annotation, reuseIdentifier: "Pin")
            annotationView?.canShowCallout = false
        }else{
            annotationView?.annotation = annotation
        }
        annotationView?.image = UIImage(named: "pin-in-the-map")
        return annotationView

    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        // 1
        if view.annotation is MKUserLocation
        {
            // Don't proceed with custom callout
            return
        }
        // 2
        let starbucksAnnotation = view.annotation as! StarbucksAnnotation
        let views = Bundle.main.loadNibNamed("CustomCalloutView", owner: nil, options: nil)
        let calloutView = views?[0] as! CustomCalloutView
        calloutView.starbucksName.text = starbucksAnnotation.name
        calloutView.starbucksAddress.text = starbucksAnnotation.descriptionFor
        calloutView.starbucksPhone.text = starbucksAnnotation.phone
        
        
        //
        let button = UIButton(frame: calloutView.starbucksPhone.frame)
        button.addTarget(self, action: #selector(MapVC.callPhoneNumber(sender:)), for: .touchUpInside)
        calloutView.addSubview(button)
        calloutView.starbucksImage.loadImageUsingFirebaseStrorage(imageName: "\(starbucksAnnotation.imageName!)")
        // 3

        
        calloutView.center = CGPoint(x: view.bounds.size.width / 2, y: -calloutView.bounds.size.height*0.52)
        view.addSubview(calloutView)
        mapView.setCenter((view.annotation?.coordinate)!, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        if view.isKind(of: AnnotationView.self)
        {
            for subview in view.subviews
            {
                subview.removeFromSuperview()
            }
        }
    }
    
    func callPhoneNumber(sender: UIButton)
    {
        let v = sender.superview as! CustomCalloutView
        let url:NSURL = URL(string: "tel://\(v.starbucksPhone.text!)")! as NSURL
        UIApplication.shared.openURL(url as URL)
    }
    


  


//    func determineMyCurrentLocation(){
//        locationManager = CLLocationManager()
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.requestAlwaysAuthorization()
//        
//        //If The Location Is enabled Then it asks for location
//        if CLLocationManager.locationServicesEnabled() {
//            locationManager.startUpdatingLocation()
//            //locationManager.startUpdatingHeading()
//        }else{
//            locationManager.requestAlwaysAuthorization()
//        }
//    }
//    
//    //Retrives Location from Phone
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let userLocation:CLLocation = locations[0] as CLLocation
//        manager.stopUpdatingLocation()
//        // Call stopUpdatingLocation() to stop listening for location updates,
//        // other wise this function will be called every time when user location changes.
//
//        currentLatitude = Double(userLocation.coordinate.latitude)
//        currentLongitude  = Double(userLocation.coordinate.longitude)
//        print("user latitude = \(userLocation.coordinate.latitude)")
//        print("user longitude = \(userLocation.coordinate.longitude)")
//        //zoomOnMap()
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
//    {
//        print("Error \(error.localizedDescription)")
//    }
    
  
//    func zoomOnMap(){
//        //zoom on map
//        let span:MKCoordinateSpan = MKCoordinateSpanMake(1.0, 1.0)
//        print("Current Users Coordinates \(currentLatitude, currentLongitude)")
//        let myLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(Double(currentLatitude!), Double(currentLongitude!))
//        
//        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
//        map.setRegion(region, animated: true)
//        self.map.showsUserLocation = true
//        print("Blue Dot Showing")
//    }
    

//    func retrievePosts(){
//        FIRDatabase.database().reference().child("Posts").observe(.childAdded, with: { (snapshot) in
//            print(snapshot)
//
//       
//                
////                let annotation = MKPointAnnotation()
////                annotation.title  = dicionary["title"] as! String?
////                annotation.coordinate = CLLocationCoordinate2D(latitude: Double(dicionary["latitude"] as! String)!, longitude: Double(dicionary["longitude"] as! String)!)
////                self.map.addAnnotation(annotation)
//            //}
//            
//        }, withCancel: nil)
//    }

    



}
