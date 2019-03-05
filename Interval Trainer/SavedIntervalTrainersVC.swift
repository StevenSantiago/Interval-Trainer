//
//  SavedIntervalTrainersVC.swift
//  Interval Trainer
//
//  Created by Steven Santiago on 3/4/17.
//  Copyright © 2017 Steven Santiago. All rights reserved.
//

import UIKit
import CoreData

class SavedIntervalTrainersVC: UIViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var savedTimers: UITableView!
    
    var timers:[Timers] = []
    var intervalTImers:[IntervalTimer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController!.navigationBar.isHidden = false
        savedTimers.dataSource = self
        savedTimers.delegate = self
        
        timers = createTimers()
        
        let fetchRequest: NSFetchRequest<IntervalTimer> = IntervalTimer.fetchRequest()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        do{
            let intervalTImers = try context.fetch(fetchRequest)
            self.intervalTImers = intervalTImers
        } catch{
            print(error)
        }
        
        
    }
    
    //This is for testing purposes. Creating will come from database store call from CreateIntervalTimer VC
    func createTimers() -> [Timers] {
        var tempTimers:[Timers] = []
        
        let timer1 = Timers(name:"Jump Rope", hour: 0, minute: 1, second: 10, restTime: 45, activeTime: 70, currentRunTime: 70, sets: 10)
        
        let timer2 = Timers(name:"Body Weight", hour: 0, minute: 0, second: 30, restTime: 10, activeTime: 30, currentRunTime: 30, sets: 15)
        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = timers[indexPath.row]
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "TimerStart") as! IntervalTimerVC
        secondViewController.intervalTimer = item
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    

}
