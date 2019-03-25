//
//  CreateIntervalTrainerVC.swift
//  Interval Trainer
// Has user create interval timer settings.
//  Created by Steven Santiago on 3/4/17.
//  Copyright © 2017 Steven Santiago. All rights reserved.
//GOod

import UIKit
import CoreData


class CreateIntervalTrainerVC: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UIScrollViewDelegate {
    
    @IBOutlet weak var timerName: UITextField!
    @IBOutlet weak var numberOfSets: UITextField!
    @IBOutlet weak var activeTime: UIPickerView!
    @IBOutlet weak var restTime: UIPickerView!
    @IBOutlet weak var menuStackView: UIStackView!
    @IBOutlet weak var createBtn: UIButton!
    @IBOutlet weak var quickStartSwitch: UISwitch!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    var activeClock = Timers(name:"Timer1", restTime: 0, activeTime: 0, sets: 0)
    
    var tName = ""
    var tSets = 0
    var editingTimer = false
    var defaultTimer = false
    var fetchedTimers:[IntervalTimer] = []
    var iTimer: IntervalTimer?
    var activeHours = 0
    var activeMinutes = 0
    var activeSeconds = 0
    var restHours = 0
    var restMinutes = 0
    var restSeconds = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController!.navigationBar.isHidden = false
        //Call from extension that closes keyboard
        self.hideKeyboardWhenTappedAround()
        activeTime.tag = 1
        activeTime.delegate = self
        activeTime.dataSource = self
        scrollView.delegate = self
        restTime.tag = 2
        restTime.delegate = self
        restTime.dataSource = self
        createBtn.isEnabled = false
        editExistingTimer()
    }
    
    @IBAction func startTimer(_ sender: Any) {
        performSegue(withIdentifier: TO_START_TIMER, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? IntervalTimerVC {
            destination.intervalTimer = activeClock
            save()// move to startTimer function?
        }
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return 24
        case 1,2:
            return 60
        default:
            return 0
        }

    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return pickerView.frame.size.width/3
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return "\(row)"
        case 1:
            return "\(row)"
        case 2:
            return "\(row)"
        default:
            return ""
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(scrollView.contentSize.height)
        switch component {
        case 0:
            if pickerView.tag == 1{
                activeHours = row
                activeClock.activeTime = Timers.convertToSeconds(h: activeHours, m: activeMinutes, s: activeSeconds)
                validUserInput()
            } else {
                restHours = row
                activeClock.restTime = Timers.convertToSeconds(h: restHours, m: restMinutes, s: restSeconds)
                validUserInput()
            }
        case 1:
            if pickerView.tag == 1{
                activeMinutes = row
                activeClock.activeTime = Timers.convertToSeconds(h: activeHours, m: activeMinutes, s: restSeconds)
                activeClock.restTime = Timers.convertToSeconds(h: restHours, m: restMinutes, s: restSeconds)
                validUserInput()
            } else {
                restMinutes = row
                activeClock.restTime = Timers.convertToSeconds(h: restHours, m: restMinutes, s: restSeconds)
                validUserInput()
            }
        case 2:
            if pickerView.tag == 1{
                restSeconds = row
                activeClock.activeTime = Timers.convertToSeconds(h: activeHours, m: activeMinutes, s: restSeconds)
                validUserInput()
            } else {
                restSeconds = row
                activeClock.restTime = Timers.convertToSeconds(h: restHours, m: restMinutes, s: restSeconds)
                validUserInput()
            }
        default:
            break;
        }
    }
    
    @IBAction func checkInput(_ sender: UITextField) {
        validUserInput()
    }
    func validUserInput(){
        if(numberOfSets.text?.isEmpty == false && timerName.text?.isEmpty == false && activeClock.activeTime != 0 && activeClock.restTime != 0){
            createBtn.isEnabled = true
            activeClock.sets = Int(numberOfSets.text!)!
            activeClock.name = String(timerName.text!)// will need to check it has name or give default name
        } else {
        createBtn.isEnabled = false
        }
    }
    
    func save(){
        var iT : IntervalTimer!
        
        if(!editingTimer){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else{return}
        oneDefaultTimer()
        let intervalT = IntervalTimer(context: managedContext)
        intervalT.activeTime = Int32(activeClock.activeTime)
        intervalT.name = activeClock.name
        intervalT.restTime = Int32(activeClock.restTime)
        intervalT.sets = Int16(activeClock.sets)
        intervalT.isDefault = quickStartSwitch.isOn
        appDelegate?.saveContext()
        } else {
            oneDefaultTimer()
            iT = iTimer
            iT.activeTime = Int32(activeClock.activeTime)
            iT.name = activeClock.name
            iT.restTime = Int32(activeClock.restTime)
            iT.sets = Int16(activeClock.sets)
            iT.isDefault = quickStartSwitch.isOn
            appDelegate?.saveContext()
        }
    }
    
    func oneDefaultTimer(){
        let fetchRequest: NSFetchRequest<IntervalTimer> = IntervalTimer.fetchRequest()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        do{
            let fetchResults = try context.fetch(fetchRequest) as [NSManagedObject]
            if(fetchResults.count >= 1){
            for index in 0...fetchResults.count-1 {
                let managedObject = fetchResults[index]
                managedObject.setValue(false, forKey: "isDefault")
                print("Id for this object is:  \(managedObject.objectID.uriRepresentation().lastPathComponent)")
                appDelegate.saveContext()
            }
            }
        } catch{
            print(error)
        }
    }
    
    func editExistingTimer() {
        if(editingTimer){
        timerName.text = tName
        numberOfSets.text = String(tSets)
        quickStartSwitch.isOn = defaultTimer
        let HMS1 = activeClock.convertToHoursMinsSeconds(Seconds: activeClock.activeTime)
        let HMS2 = activeClock.convertToHoursMinsSeconds(Seconds: activeClock.restTime)
        activeTime.selectRow(HMS1.0, inComponent: 0, animated: true)
        activeTime.selectRow(HMS1.1, inComponent: 1, animated: true)
        activeTime.selectRow(HMS1.2, inComponent: 2, animated: true)
        restTime.selectRow(HMS2.0, inComponent: 0, animated: true)
        restTime.selectRow(HMS2.1, inComponent: 1, animated: true)
        restTime.selectRow(HMS2.2, inComponent: 2, animated: true)
        createBtn.setTitle("Save", for: .normal)
        validUserInput()
        }
    }
    
    

}
