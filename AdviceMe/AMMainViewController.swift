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
       
                
                if result != nil
                {
                    self.textLabel.text = result.text
                    self.searchAdvise()
                    let loadVC = LoadingViewController()
                    self.addChildViewController(loadVC)
                    self.view.addSubview(loadVC.view)
                    
                }
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
    
    func searchAdvise()
    {
        if let text = textLabel.text where !text.isEmpty
        {
            let s = Servicehandler()
            s.searchQuote(text) { (quotesList) -> Void in
            
                self.adviceList = quotesList
                self.advicesTableView.reloadData()
            }
        }
        else
        {
            let alertActionVC = UIAlertController(title: "Oops", message: "Can you say again?", preferredStyle: UIAlertControllerStyle.Alert)
            
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
