//
//  DisplayTimer.swift
//  Interval Trainer
//
//  Created by Steven on 2/21/19.
//  Copyright © 2019 Steven Santiago. All rights reserved.
//

import UIKit

@IBDesignable
class DisplayTimer: UILabel {

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpLabel()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setUpLabel()
    }
    
    func setUpLabel(){
        self.font = UIFont(name: "Laserian", size: 45.0)
        self.adjustsFontSizeToFitWidth = true
    }
    
}


