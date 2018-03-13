//
//  DetailedViewController.swift
//  Cluster
//
//  Created by Aditya Emani on 3/12/18.
//  Copyright © 2018 Aditya Emani. All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController {
    @IBOutlet weak var weatherSlider: WeatherSlider!
    
    @IBOutlet weak var infoLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.weatherSlider.values = [0, 1,2,3];
        self.weatherSlider.labels = ["1 month","6 months", "1 year", "2 years"];
        self.weatherSlider.labelsFont = UIFont(name: "HelveticaNeue-Light", size: 14.0)!
        
        self.weatherSlider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        updateLabel()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func sliderValueChanged(){
        updateLabel()
    }
    
    func updateLabel(){
        infoLabel.text = weatherSlider.currentValue as? String;
    }

}
