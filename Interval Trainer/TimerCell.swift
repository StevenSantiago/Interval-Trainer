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
    
    
    func setTimerCell(timer: Timers){
        InteralTimerName.text = timer.name
        self.sets.text = String(timer.sets)
        self.activeTime.text = String(timer.activeTime)
        self.restTime.text = String(timer.restTime)
    }
}


