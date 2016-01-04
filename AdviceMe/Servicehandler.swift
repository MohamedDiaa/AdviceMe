//
//  Servicehandler.swift
//  AdviceMe
//
//  Created by MohamedDiaa on 1/4/16.
//  Copyright © 2016 MohamedDiaa. All rights reserved.
//

import UIKit
import Alamofire
import AEXML

class Servicehandler: NSObject {

    func searchQuote(searchText : String , completion:(quotesList:[Advice]?) -> Void )
    {
    
        let link = "http://www.stands4.com/services/v2/quotes.php?uid=4704&tokenid=gpZDtHdmCb4cUdHz&searchtype=SEARCH&query=Albert+Einstein"
        
        let linkString = link.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet()) ?? link

        Alamofire.request(.GET, linkString, parameters: nil)
            .responseData { response in
                
                print(response.request)
                print(response.response)
                print(response.result)
                
             if let data = response.data
             {
                let list = self.parseData(data)
               return completion(quotesList: list)
             }
        
               return completion(quotesList: nil)
        }
    }
    
    func parseData(data:NSData) -> [Advice]?
    {
        do {
            let xmlDoc = try AEXMLDocument(xmlData: data)
            
            var adviceList = [Advice]()
            
            for child in xmlDoc.root.children {
              
               // print(child.name)
                 let advice = Advice()
                
                let cats = child.children[0]
                advice.quote = cats.value ?? ""
                
                let cats_2 = child.children[1]
                advice.author = cats_2.value ?? ""

                adviceList.append(advice)
              }
                return adviceList
            }
        catch {
            print("\(error)")
        }
        
        return nil
    }

}
