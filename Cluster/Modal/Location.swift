//
//  Location.swift
//  Cluster
//
//  Created by Aditya Emani on 3/11/18.
//  Copyright © 2018 Aditya Emani. All rights reserved.
//

import Foundation

class Location
{
    let _id:String;
    let lat:Double;
    let lng:Double;
    let locationName:String;
    
    init(src:Dictionary<String, Any>) {
        self._id = src["_id"]! as! String;
        self.lat = src["lat"]! as! Double;
        self.lng = src["lng"]! as! Double;
        self.locationName = src["locationName"]! as! String;
    }
}
