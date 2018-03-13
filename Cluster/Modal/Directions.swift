//
//  Directions.swift
//  Cluster
//
//  Created by Aditya Emani on 3/11/18.
//  Copyright © 2018 Aditya Emani. All rights reserved.
//

import Foundation

class Directions
{
    let company: String
    let category: String
    let price: Double
    let score: Double
    let percent: Double
    let isGrowing: Bool
    var isClosed: Bool = false
    
    init(company: String, category: String, price: Double, score: Double, percent: Double, isGrowing: Bool, isClosed: Bool = false) {
        self.company = company
        self.category = category
        self.price = price
        self.score = score
        self.percent = percent
        self.isGrowing = isGrowing
        self.isClosed = isClosed
    }
}
