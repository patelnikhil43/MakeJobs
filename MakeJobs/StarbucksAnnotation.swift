//
//  Starbuck.swift
//  MakeJobs
//
//  Created by Nikhil on 5/16/17.
//  Copyright © 2017 Nikhil. All rights reserved.
//
import MapKit

class StarbucksAnnotation: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var phone: String!
    var name: String!
    var descriptionFor: String!
    var image: UIImage!
    var imageName: String!
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
