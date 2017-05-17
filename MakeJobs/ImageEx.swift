//
//  ImageEx.swift
//  MakeJobs
//
//  Created by Nikhil on 5/15/17.
//  Copyright © 2017 Nikhil. All rights reserved.
//

import UIKit
import Firebase
let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {

func loadImageUsingFirebaseStrorage(imageName: String){
    //if there is a chached image it uses that or else it downloads it in the next method
    if let cachedImage = imageCache.object(forKey: imageName as AnyObject) as? UIImage{
        self.image = cachedImage
        return
    }
    
    let imageRef  = FIRStorage.storage().reference().child("PostedImages/\(imageName)")
    imageRef.downloadURL { (url, error) in
        if error == nil {
            URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                if (error != nil){
                    print(error!.localizedDescription)
                    return
                }
                DispatchQueue.main.async {
                    if let downloadImage  = UIImage(data: data!){
                        imageCache.setObject(downloadImage, forKey: imageName as AnyObject)
                        self.image  = downloadImage
                    }
                }
            }).resume()
        }else {
            print(error!.localizedDescription)
        }
    }
}

}
