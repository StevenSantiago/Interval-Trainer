//
//  SavedTimer.swift
//  Interval Trainer
//
//  Created by Steven on 2/27/19.
//  Copyright © 2019 Steven Santiago. All rights reserved.
//

import UIKit

class TimerCell: UITableViewCell {
    
    @IBOutlet weak var InteralTimerName: UILabel!
    @IBOutlet weak var sets: UILabel!
    @IBOutlet weak var activeTime: UILabel!
    @IBOutlet weak var restTime: UILabel!
    
    
    func setTimerCell(timer: IntervalTimer){
        InteralTimerName.text = timer.name
        self.sets.text = "Sets: " + String(timer.sets)
        self.activeTime.text = "Active: " + String(timer.activeTime) + " s"
        self.restTime.text = "Rest: " + String(timer.restTime) + " s"
    }
}


