//
//  Dataservices.swift
//  CoolPlaces
//
//  Created by Pablo Sedano on 7/21/16.
//  Copyright © 2016 Pablo Sedano. All rights reserved.
//

import Foundation
import Firebase

class Dataservices {
    static let ds = Dataservices()
    
    private var _REF_BASE = FIRDatabase.database().reference()
    
    var REF_BASE : FIRDatabaseReference {
        return _REF_BASE
    }
}
