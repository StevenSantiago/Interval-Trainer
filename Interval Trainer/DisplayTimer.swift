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
        updateLabel()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        updateLabel()
    }
    
    func updateLabel(){
        self.font = UIFont(name: "Laserian", size: 45.0)
        self.adjustsFontSizeToFitWidth = true
    }
    
    func formatDisplay(hour:Int,min:Int,sec:Int){
        if hour > 0 {
            self.text = String(hour) + ":" + String(format:"%02d",min) + ":" + String(format: "%02d",sec)
        } else {
            self.text = String(min) + ":" + String(format: "%02d",sec)
        }
    }
    
}


