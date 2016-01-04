//
//  LoadingViewController.swift
//  AdviceMe
//
//  Created by MohamedDiaa on 1/3/16.
//  Copyright © 2016 MohamedDiaa. All rights reserved.
//

import UIKit
import QuartzCore

// Hex Color Convenience Function
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}

protocol CircleViewDelegate
{
    func animationDidFinish(circleView :CircleView)
}


class CircleView: UIView {
    
    var delegate : CircleViewDelegate?
    
    let circleLayer = CAShapeLayer()
    
    init(frame: CGRect , delegate :CircleViewDelegate ) {
        super.init(frame: frame)
        
        self.delegate = delegate
        self.backgroundColor = UIColor.clearColor()
        
        //Draws the circle
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: 0, y: 0), radius: (frame.size.width)/2, startAngle: 0.0, endAngle: CGFloat(M_PI * 2.0), clockwise: true)
        
        circleLayer.path = circlePath.CGPath
        circleLayer.fillColor = UIColor.clearColor().CGColor
        circleLayer.strokeColor = UIColor(netHex: 0xf8a000).CGColor
        circleLayer.lineWidth = 4.0
        circleLayer.strokeEnd = 0
        
        layer.addSublayer(circleLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animateCircle(duration: NSTimeInterval) {
        
        CATransaction.begin()
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        
        //Animates the strokeEnd property
        animation.duration = duration
        animation.fromValue = 0
        animation.toValue = 1.0
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.delegate = self
        self.circleLayer.strokeEnd = 1.0
        
        CATransaction.setCompletionBlock { () -> Void in
            self.delegate?.animationDidFinish(self)
            self.removeFromSuperview()
        }
        
        circleLayer.addAnimation(animation, forKey: "animateCircle")
        CATransaction.commit()
    }
}


class LoadingViewController: UIViewController, CircleViewDelegate  {

        override func viewDidLoad() {
            super.viewDidLoad()
            
            self.view.backgroundColor = UIColor.clearColor() //UIColor(netHex: 0x007deb)
            
            let maxShapes = 11
            for i in 0..<maxShapes {
                //Creates concentric circles
                self.view.addSubview(self.createCircle(320 - CGFloat(i*22)))
            }
            
        }
        
        func createCircle(diameter: CGFloat) -> UIView {
            
            //Places the circle in the view
            let circleView = CircleView(frame: CGRectMake(self.view.frame.midX, self.view.frame.midY, diameter, diameter), delegate: self)
            
            //Sets a random duration for the animation between 2-3 seconds
            let randomDuration = Double(arc4random())/Double(UInt32.max) + 2
            //Annoying way to delay the animation
            dispatch_after(dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(1 * Double(NSEC_PER_SEC))
                ), dispatch_get_main_queue()){
                    circleView.animateCircle(randomDuration)
            }
            
            return circleView
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        override func prefersStatusBarHidden() -> Bool {
            return true
        }
    
    func animationDidFinish(circleView: CircleView) {
        
        if self.view.subviews.count == 0
        {
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
        }
    }
}

