//
//  Helper.swift
//  AdviceMe
//
//  Created by MohamedDiaa on 1/4/16.
//  Copyright © 2016 MohamedDiaa. All rights reserved.
//

import UIKit

class Helper: NSObject {

}

func detectInternet() -> Bool
{
    /*
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable) {
    NSLog(@"There IS NO internet connection");
    } else {
    NSLog(@"There IS internet connection");
    }
    */
    
    let networkReachability = Reachability.reachabilityForInternetConnection()
    let networkStatus = networkReachability.currentReachabilityStatus()
    if networkStatus == NotReachable
    {
        return false
    }
    else
    {
        return true
    }
}
