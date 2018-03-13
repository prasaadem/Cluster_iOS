//
//  StepHelper.swift
//  Cluster
//
//  Created by Aditya Emani on 3/11/18.
//  Copyright © 2018 Aditya Emani. All rights reserved.
//

import Foundation

class StepsHelper {
    static func generateSteps() -> [Step] {
        var steps: [Step] = []
        let path = Bundle.main.path(forResource: "steps", ofType: "plist")
        let s = NSArray(contentsOfFile: path!)
        for step in s! {
            steps.append(Step(src: step as! Dictionary<String, Any>))
        }
        return steps
    }
}
