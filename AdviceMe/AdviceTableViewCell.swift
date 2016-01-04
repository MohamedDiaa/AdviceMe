//
//  AdviceTableViewCell.swift
//  AdviceMe
//
//  Created by MohamedDiaa on 1/4/16.
//  Copyright © 2016 MohamedDiaa. All rights reserved.
//

import UIKit

class AdviceTableViewCell: UITableViewCell {

    @IBOutlet var authorLabel : UILabel!
    @IBOutlet var adviceLabel : UILabel!
    
    func setWithAdvice(advice:Advice)
    {
        self.authorLabel.text = advice.author
        self.adviceLabel.text = advice.quote
    }
}
