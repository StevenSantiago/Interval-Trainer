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
    
    var intervalTimers:[IntervalTimer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController!.navigationBar.isHidden = false
        savedTimers.dataSource = self
        savedTimers.delegate = self
        
        
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
        return UITableViewCell.EditingStyle.delete//Currently does not do anything due to UITableViewRowAction
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "DELETE") { (rowAction, indexPath) in
            self.removeIntervalTimer(indexPath: indexPath)
            self.fetchCoreData()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        let editAction = UITableViewRowAction(style: .normal, title: "EDIT") { (rowAction, indexPath) in
            print("Editing timer")
            let item = self.intervalTimers[indexPath.row]
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "CreateIntervalTrainerVC") as! CreateIntervalTrainerVC
            secondViewController.tName = item.name!
            secondViewController.tSets = Int(item.sets)
            secondViewController.activeClock.activeTime = Int(item.activeTime)
            secondViewController.activeClock.restTime = Int(item.restTime)
            secondViewController.defaultTimer = item.isDefault
            secondViewController.editingTimer = true
            secondViewController.iTimer = item
            self.navigationController?.pushViewController(secondViewController, animated: true)
        }
        deleteAction.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        editAction.backgroundColor = #colorLiteral(red: 0, green: 1, blue: 0.3671256304, alpha: 1)
        return [deleteAction,editAction]
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
        secondViewController.intervalTimer.name = item.name!
        secondViewController.intervalTimer.sets = Int(item.sets)
        secondViewController.intervalTimer.activeTime = Int(item.activeTime)
        secondViewController.intervalTimer.restTime = Int(item.restTime)
        secondViewController.currentRunTime = Int(item.activeTime)
        
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
