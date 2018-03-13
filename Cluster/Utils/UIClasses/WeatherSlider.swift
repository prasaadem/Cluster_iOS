//
//  WeatherSlider.swift
//  Cluster
//
//  Created by Aditya Emani on 3/12/18.
//  Copyright © 2018 Aditya Emani. All rights reserved.
//

import UIKit

let HorizontalInsets:CGFloat = 45.0
let BottomOffset:CGFloat = 15.0;

@IBDesignable
class WeatherSlider: UIControl {
    
    @IBInspectable var circlesRadius:CGFloat = 12.0;
    @IBInspectable var circlesRadiusForSelected:CGFloat = 26.0;
    @IBInspectable var textOffset:CGFloat = 30.0;
    
    var basicColor:UIColor?
    var labelColor:UIColor?;
    var selectedValueColor:UIColor?;
    var selectedLabelColor:UIColor?;
    var labelsFont:UIFont = UIFont(name:"Helvetica-Light",size:16.0)!
    var values:[NSInteger] = [];
    var labels:[String] = [];
    var currentValue:NSObject?;
    var selectedItemIndex:NSInteger = 0;
    
    var sliderLayer:CAShapeLayer = CAShapeLayer();
    var circlesLayer:CAShapeLayer = CAShapeLayer();
    var selectedLayer:CAShapeLayer = CAShapeLayer();
    var labelsLayer:CAShapeLayer = CAShapeLayer();
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupProperties()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupProperties()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupLayers()
    }
    
    override func prepareForInterfaceBuilder() {
        self.setupLayers()
    }
    
    override func layoutSubviews() {
        self.updateLayers()
        self.setNeedsDisplay()
    }
    
    func setupProperties(){
        basicColor = UIColor.init(white: 0.7, alpha: 1.0)
        selectedValueColor = UIColor.black
        selectedLabelColor = UIColor.black
        labelColor = UIColor.gray
        
        textOffset = 30.0
        circlesRadius = 12.0
        circlesRadiusForSelected = 26.0
        
        selectedItemIndex = 0
        values = [0,1,2]
        labels = ["item 0", "item 1", "item 2"]
        
        labelsFont = UIFont(name:"Helvetica-Light",size:16.0)!
    }
    
    // MARK: - Shape Layers
    func setupLayers(){
        sliderLayer = CAShapeLayer()
        sliderLayer.lineWidth = 3.0
        
        layer.addSublayer(sliderLayer)
        
        circlesLayer = CAShapeLayer()
        layer.addSublayer(circlesLayer)
        
        selectedLayer = CAShapeLayer()
        layer.addSublayer(selectedLayer)
    }
    
    func updateLayers(){
        sliderLayer.strokeColor = basicColor?.cgColor;
        sliderLayer.path = self.pathForSlider().cgPath
        
        circlesLayer.fillColor = basicColor?.cgColor;
        circlesLayer.path = self.pathForCircles().cgPath
        
        selectedLayer.fillColor = selectedValueColor?.cgColor
        selectedLayer.path = self.pathForSelected().cgPath
    }
    
    func animateSelectionChange(){
        let oldPath:CGPath = selectedLayer.path!;
        let newPath:CGPath = self.pathForSelected().cgPath;
        
        let pathAnimation:CABasicAnimation = CABasicAnimation(keyPath: "path")
        
        pathAnimation.fromValue = oldPath;
        pathAnimation.toValue = newPath;
        
        pathAnimation.duration = 0.25;
        pathAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 0.2, 1.0, 0.7, 1.0)
        
        selectedLayer.path = newPath;
        selectedLayer.add(pathAnimation, forKey: "PathAnimation")
    }
    
    func pathForSlider() -> UIBezierPath{
        let path = UIBezierPath()
        let lineY = self.bounds.size.height - self.circlesRadius - BottomOffset
        path.move(to: CGPoint(x: circlesRadius+HorizontalInsets, y: lineY))
        path.addLine(to: CGPoint(x:self.bounds.size.width - circlesRadius - HorizontalInsets,y:lineY))
        path.close()
        return path
    }
    
    func pathForCircles() -> UIBezierPath{
        let path:UIBezierPath = UIBezierPath()
        let startPointX:CGFloat = circlesRadius + HorizontalInsets
        let intervalSize:CGFloat = (self.bounds.size.width - (circlesRadius+HorizontalInsets) * 2.0) / CGFloat(values.count-1)
        
        let yPos = bounds.size.height - circlesRadius - BottomOffset
        
        for var i in (0..<values.count){
            let center = CGPoint(x: startPointX + CGFloat(i) * intervalSize, y: yPos)
            path.addArc(withCenter: center, radius: circlesRadius, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
            path.close()
        }
        return path;
    }
    
    func pathForSelected() -> UIBezierPath{
        
        let path = UIBezierPath()
        let startPointX = bounds.origin.x + circlesRadius + HorizontalInsets
        let intervalSize = (bounds.size.width - (circlesRadius + HorizontalInsets) * 2.0) / CGFloat(values.count - 1)
        
        let yPos = bounds.origin.y + bounds.size.height - circlesRadius - BottomOffset
        let center = CGPoint(x: startPointX + CGFloat(selectedItemIndex) * intervalSize, y: yPos)
        
        path.addArc(withCenter: center, radius: circlesRadiusForSelected, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
        return path;
    }
    
    //Mark - UIView drawing
    
    override func draw(_ rect: CGRect) {
        drawLabels()
    }
    
    func drawLabels(){
        let startPointX = bounds.origin.x + circlesRadius + HorizontalInsets
        let intervalSize = (bounds.size.width - (circlesRadius + HorizontalInsets) * 2.0) / CGFloat(values.count - 1)
        
        let yPos = bounds.origin.y + bounds.size.height + 5 - circlesRadiusForSelected - BottomOffset * 2
        
        for var i in (0..<values.count){
            let textColor = selectedItemIndex == i ? selectedLabelColor : labelColor
            draw(label: labels[i], at: CGPoint(x:startPointX + CGFloat(i) * intervalSize, y: yPos - circlesRadius - textOffset), with: textColor!)
        }
    }
    
    func draw(label:String, at point:CGPoint, with color:UIColor){
        let textStyle:NSMutableParagraphStyle =  NSMutableParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        textStyle.alignment = .center
        
        let rect = CGRect(x: point.x - 40, y: point.y - 10, width: 70, height: 60)
        
        let textFontAttributes = [NSAttributedStringKey.font: labelsFont, NSAttributedStringKey.foregroundColor: color, NSAttributedStringKey.paragraphStyle: textStyle]
        
        label.draw(in: rect, withAttributes: textFontAttributes)
    }
    
    // Mark - Touch handlers
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (touches.count > 1){return;}
        
        let touch:UITouch = touches.first!
        switchSelectionForTouch(touch: touch)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (touches.count > 1){return;}
        
        let touch:UITouch = touches.first!
        switchSelectionForTouch(touch: touch)
    }
    
    func switchSelectionForTouch(touch:UITouch){
        let location = touch.location(in: self)
        
        let index:NSInteger = indexForTouchPoint(point: location)
        
        let canSwitch:Bool = index >= 0 && index < values.count && index != selectedItemIndex
        
        if(canSwitch){
            setSelectedItemIndex(selectedIndex: index, animated: true)
            sendActions(for: .valueChanged)
        }
    }
    
    func indexForTouchPoint(point:CGPoint) -> NSInteger{
        let startPointX:CGFloat = bounds.origin.x + circlesRadius + HorizontalInsets
        let intervalSize:CGFloat = (bounds.size.width - (circlesRadius + HorizontalInsets) * 2.0) / CGFloat(values.count - 1)
        
        let yPos:CGFloat = bounds.origin.y + bounds.size.height - circlesRadius - BottomOffset
        
        let approximateIndex:NSInteger = NSInteger(round((point.x - startPointX) / intervalSize))
        let xAccuracy = fabs(point.x - (startPointX + CGFloat(approximateIndex) * intervalSize))
        let yAccuracy = fabs(yPos - point.y)
        
        if(xAccuracy > circlesRadius * 2.4 || yAccuracy > bounds.size.height * 0.8){
            return -1
        }
        
        return approximateIndex
    }
    
    // Mark - Properties
    
    func setValues(v:[NSInteger]){
        values = v
        selectedItemIndex = 0
        setNeedsDisplay()
        setNeedsLayout()
    }
    
    func setSelectedItemIndex(selectedIndex:NSInteger){
        selectedItemIndex = selectedIndex
        updateLayers()
        setNeedsDisplay()
    }
    
    func setSelectedItemIndex(selectedIndex:NSInteger, animated:Bool){
        selectedItemIndex = selectedIndex
        if(animated){
            animateSelectionChange()
        }else{
            updateLayers()
        }
        setNeedsDisplay()
    }
    
    func getCurrentValue() -> NSInteger {
        return values[selectedItemIndex]
    }
    
    // Mark - UIAccessibility
    func isAccessibilityElement() -> Bool{
        return true
    }
    
    func accessibilityLabel() -> String{
        if(selectedItemIndex < labels.count){
            return labels[selectedItemIndex]
        }else{
            return ""
        }
    }
    
    func accessibilityTraits() -> UIAccessibilityTraits{
        return UIAccessibilityTraitSelected | UIAccessibilityTraitAdjustable | UIAccessibilityTraitSummaryElement
    }
    
    func accessibilityElement(){
        if(selectedItemIndex < labels.count - 1){
            setSelectedItemIndex(selectedIndex: selectedItemIndex + 1, animated: true)
        }
    }
    
    override func accessibilityDecrement(){
        if(selectedItemIndex > 0){
            setSelectedItemIndex(selectedIndex: selectedItemIndex - 1, animated: true)
        }
    }
}
