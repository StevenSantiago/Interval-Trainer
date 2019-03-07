//
//  SavedIntervalTrainersVC.swift
//  Interval Trainer
//
//  Created by Steven Santiago on 3/4/17.
//  Copyright © 2017 Steven Santiago. All rights reserved.
// TODO: Need to load tableview with saved data

import UIKit
import CoreData

class SavedIntervalTrainersVC: UIViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var savedTimers: UITableView!
    
    var timers:[Timers] = []
    var intervalTimers:[IntervalTimer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController!.navigationBar.isHidden = false
        savedTimers.dataSource = self
        savedTimers.delegate = self
        
        //timers = createTimers()
        
        let fetchRequest: NSFetchRequest<IntervalTimer> = IntervalTimer.fetchRequest()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        do{
            let intervalTimers = try context.fetch(fetchRequest)
            self.intervalTimers = intervalTimers
            self.savedTimers.reloadData() 
        } catch{
            print(error)
        }
        
        
    }
    
    
    
    //This is for testing purposes. Creating will come from database store call from CreateIntervalTimer VC
//    func createTimers() -> [Timers] {
//        var tempTimers:[Timers] = []
//
//        let timer1 = Timers(name:"Jump Rope", hour: 0, minute: 1, second: 10, restTime: 45, activeTime: 70, currentRunTime: 70, sets: 10)
//
//        let timer2 = Timers(name:"Body Weight", hour: 0, minute: 0, second: 30, restTime: 10, activeTime: 30, currentRunTime: 30, sets: 15)
//
//        tempTimers.append(timer1)
//        tempTimers.append(timer2)
//
//        return tempTimers
//    }
    
    func removeIntervalTimer(indexPath: IndexPath){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else{return}
        managedContext.delete(intervalTimers[indexPath.row])
        appDelegate?.saveContext()
        print("Deleted Timer!")
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true // allow editing of table view
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.delete
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "DELETE") { (rowAction, indexPath) in
            print("Number of intervalTimers is: \(self.intervalTimers.count)")
            self.removeIntervalTimer(indexPath: indexPath)
            self.fetchCoreData()
            print("Number of intervalTimers is: \(self.intervalTimers.count)")
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
        }
        deleteAction.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        return [deleteAction]
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return intervalTimers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let timer = intervalTimers[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "TimerCell", for: indexPath) as! TimerCell
        cell.setTimerCell(timer: timer)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = intervalTimers[indexPath.row]
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "TimerStart") as! IntervalTimerVC
        //secondViewController.intervalTimer = item
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    
    func fetchCoreData(){
        let fetchRequest: NSFetchRequest<IntervalTimer> = IntervalTimer.fetchRequest()
        let context = appDelegate!.persistentContainer.viewContext
        
        do{
            let intervalTimers = try context.fetch(fetchRequest)
            self.intervalTimers = intervalTimers
        } catch{
            print(error)
        }
    }
    

}
