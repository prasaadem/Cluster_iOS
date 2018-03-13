//
//  Step.swift
//  Cluster
//
//  Created by Aditya Emani on 3/11/18.
//  Copyright © 2018 Aditya Emani. All rights reserved.
//

import UIKit

class Step
{
    let _id: String;
    let distance: String;
    let duration: String;
    let start_location: Location;
    let end_location: Location;
    let weather: Weather;
    
    init(src:Dictionary<String, Any>) {
        self._id = src["_id"]! as! String;
        self.distance = src["distance"]! as! String;
        self.duration = src["duration"]! as! String;
        
        self.start_location = Location(src: src["start_location"]! as! Dictionary<String, Any>);
        self.end_location = Location(src: src["end_location"]! as! Dictionary<String, Any>);
        
        self.weather = Weather(src: src["weather"]! as! Dictionary<String, Any>);
    }
}
