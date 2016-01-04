//
//  Servicehandler.swift
//  AdviceMe
//
//  Created by MohamedDiaa on 1/4/16.
//  Copyright © 2016 MohamedDiaa. All rights reserved.
//

import UIKit
import Alamofire

class Servicehandler: NSObject {

    
    func searchQuote(searchText : String , completion:(quotesList:[String]) -> Void )
    {
    
        let link = "http://www.stands4.com/services/v2/quotes.php?uid=4704&tokenid=gpZDtHdmCb4cUdHz&searchtype=SEARCH&query=Albert+Einstein"
        
        let linkString = link.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet()) ?? link

        Alamofire.request(.GET, linkString, parameters: nil)
            .responseData { response in
                print(response.request)
                print(response.response)
                print(response.result)
        }
    
    }
    
}
