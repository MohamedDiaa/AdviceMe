//
//  AMMainViewController.swift
//  AdviceMe
//
//  Created by MohamedDiaa on 1/1/16.
//  Copyright © 2016 MohamedDiaa. All rights reserved.
//

import UIKit

class AMMainViewController: UIViewController , ISSpeechRecognitionDelegate {

    @IBOutlet var textLabel :UILabel!
    
    var recognition : ISSpeechRecognition?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func recognize(sender:UIButton)
    {
        let recognition = ISSpeechRecognition()
        recognition.freeformType = UInt(ISFreeFormTypeDictation)
        recognition.delegate = self
        self.recognition = recognition
        
        recognition.listenAndRecognizeWithTimeout(10) { (error, result, success) -> Void in
       
            if !success
            {
                self.textLabel.text = result.text
            }
            let loadVC = LoadingViewController()
            self.addChildViewController(loadVC)
            self.view.addSubview(loadVC.view)

        }
    }
    
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

}
