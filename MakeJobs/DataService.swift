//
//  DataServices.swift
//  MakeJobs
//
//  Created by Nikhil on 5/13/17.
//  Copyright © 2017 Nikhil. All rights reserved.
//


import Foundation
import Firebase
import FirebaseDatabase
import KeychainSwift

let DB_BASE = FIRDatabase.database().reference()

class DataSerivce{
    private var _keyChain = KeychainSwift()
    private var _refDatabase = DB_BASE
    
    var keyChain: KeychainSwift{
        get {
            return _keyChain
        } set{
            _keyChain = newValue
        }
    }
}
