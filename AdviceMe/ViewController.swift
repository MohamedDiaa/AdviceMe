//
//  ViewController.swift
//  AdviceMe
//
//  Created by MohamedDiaa on 12/27/15.
//  Copyright © 2015 MohamedDiaa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let controller = AMMainViewController(nibName: "AMMainViewController", bundle: nil)
        self.addChildViewController(controller)
        self.view.addSubview(controller.view)
        
        controller.view.translatesAutoresizingMaskIntoConstraints = false
       let c1 = NSLayoutConstraint(item: controller.view, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 0.0)
        
       let c2 = NSLayoutConstraint(item: controller.view, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: 0.0)
    
        
       let c3 = NSLayoutConstraint(item: controller.view, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0.0)
    
        
       let c4 = NSLayoutConstraint(item: controller.view, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0.0)
        
        self.view.addConstraints([c1,c2,c3,c4])
        
        
        let s = Servicehandler()
        s.searchQuote("albert") { (quotesList) -> Void in
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

