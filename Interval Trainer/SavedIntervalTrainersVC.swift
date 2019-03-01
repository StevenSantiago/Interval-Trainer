//
//  SavedIntervalTrainersVC.swift
//  Interval Trainer
//
//  Created by Steven Santiago on 3/4/17.
//  Copyright © 2017 Steven Santiago. All rights reserved.
//

import UIKit

class SavedIntervalTrainersVC: UIViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var savedTimers: UITableView!
    
    var timers:[Timers] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController!.navigationBar.isHidden = false
        savedTimers.dataSource = self
        savedTimers.delegate = self
        
        timers = createTimers()
    }
    
    func createTimers() -> [Timers] {
        var tempTimers:[Timers] = []
        
        let timer1 = Timers(hour: 0, minute: 1, second: 10, restTime: 45, activeTime: 50, currentRunTime: 0, sets: 10)
        
        let timer2 = Timers(hour: 0, minute: 0, second: 30, restTime: 10, activeTime: 30, currentRunTime: 0, sets: 15)
        
        tempTimers.append(timer1)
        tempTimers.append(timer2)
        
        return tempTimers
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let timer = timers[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "TimerCell", for: indexPath) as! TimerCell
        cell.setTimerCell(timer: timer)
        return cell
    }

}
