//
//  StepCell.swift
//  Cluster
//
//  Created by Aditya Emani on 3/11/18.
//  Copyright © 2018 Aditya Emani. All rights reserved.
//

import UIKit
import DottedLineView

class StepCell: UICollectionViewCell {
    
    
    @IBOutlet weak var startLocation: UILabel!
    @IBOutlet weak var endLocation: UILabel!
    @IBOutlet weak var dottedView: UIView!
    
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var distance: UILabel!
    
    @IBOutlet weak var weatherImage: UIImageView!
    
    @IBOutlet weak var weatherLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 8
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.masksToBounds = false
    }

    func configureWith(_ step: Step) {
//        companyLabel.text = step.distance
//        categoryLabel.text = step.duration
//        priceLabel.text = "\(step.weather.temperature)"
//        tendencyLabel.text = step.weather.date
        
        distance.text = step.distance
        duration.text = step.duration
        
        startLocation.text = "Memphis"
        endLocation.text = "Madison"
        
        weatherLabel.text = step.weather.date

    }
    
    private func twoDigitsFormatted(_ val: Double) -> String {
        return String(format: "%.0.2f", val)
    }
}
