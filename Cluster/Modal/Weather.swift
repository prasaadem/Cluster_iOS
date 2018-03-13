//
//  Weather.swift
//  Cluster
//
//  Created by Aditya Emani on 3/11/18.
//  Copyright © 2018 Aditya Emani. All rights reserved.
//

import Foundation

struct Weather
{
    let date:String;
    let _id:String;
    let summary:String;
    let icon:String;
    let temperature:Double;
    
    init(src:Dictionary<String, Any>) {
        self.date = src["date"]! as! String;
        self._id = src["_id"]! as! String;
        self.summary = src["summary"]! as! String;
        self.icon = src["icon"]! as! String;
        self.temperature = src["temperature"]! as! Double;
    }
}
