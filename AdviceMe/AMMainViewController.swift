//
//  AMMainViewController.swift
//  AdviceMe
//
//  Created by MohamedDiaa on 1/1/16.
//  Copyright © 2016 MohamedDiaa. All rights reserved.
//

import UIKit

class AMMainViewController: UIViewController , ISSpeechRecognitionDelegate , UITableViewDataSource,UITableViewDelegate{

    @IBOutlet var textLabel :UILabel!
    @IBOutlet var advicesTableView : UITableView!
    
    var adviceList : [Advice]?
    
    var recognition : ISSpeechRecognition?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.advicesTableView.registerNib(UINib(nibName: "AdviceTableViewCell", bundle: nil), forCellReuseIdentifier: "AdviceTableViewCell")
        
        self.advicesTableView.rowHeight = UITableViewAutomaticDimension
        self.advicesTableView.estimatedRowHeight = 100.0
    
        let s = Servicehandler()
        s.searchQuote("albert") { (quotesList) -> Void in
            self.adviceList = quotesList
            self.advicesTableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func recognize(sender:UIButton)
    {
        if detectInternet()
        {
            let recognition = ISSpeechRecognition()
            recognition.freeformType = UInt(ISFreeFormTypeDictation)
            recognition.delegate = self
            self.recognition = recognition
     
            recognition.listenAndRecognizeWithTimeout(10) { (error, result, success) -> Void in
       
                self.textLabel.text = result.text
            
                let loadVC = LoadingViewController()
                self.addChildViewController(loadVC)
                self.view.addSubview(loadVC.view)
                
            }
        }
        else
        {
        
            let alertActionVC = UIAlertController(title: "Oops", message: "Could not summon the souls of the Wise men,Please check your internet connection", preferredStyle: UIAlertControllerStyle.Alert)
            
            let action = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
              
                alertActionVC.dismissViewControllerAnimated(true, completion: { () -> Void in
                    
                })
            })
            
        alertActionVC.addAction(action)
            self.presentViewController(alertActionVC, animated: true, completion: { () -> Void in
                

                
            })
            
        }
    }
    
    //*********//***********//*********//********//*******//
    //*********//***********//*********//********//*******//

    func recognition(speechRecognition: ISSpeechRecognition!, didFailWithError error: NSError!) {
        
    }
    func recognition(speechRecognition: ISSpeechRecognition!, didGetRecognitionResult result: ISSpeechRecognitionResult!) {
        
        self.textLabel.text = result.text
        

    }
    func recognitionCancelledByUser(speechRecognition: ISSpeechRecognition!) {
        
    }
    func recognitionDidBeginRecording(speechRecognition: ISSpeechRecognition!) {
        
    }
    func recognitionDidFinishRecording(speechRecognition: ISSpeechRecognition!) {
        
    }

    //*********//***********//*********//********//*******//
    //*********//***********//*********//********//*******//

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("AdviceTableViewCell") as! AdviceTableViewCell
        
        if let list = adviceList where list.count > indexPath.row
        {
            cell.setWithAdvice(list[indexPath.row])
        }
    
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let list = adviceList
        {
            return list.count
        }
        return  0
    }
    
}
