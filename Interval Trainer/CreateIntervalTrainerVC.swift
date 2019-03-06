//
//  CreateIntervalTrainerVC.swift
//  Interval Trainer
// Has user create interval timer settings.
//  Created by Steven Santiago on 3/4/17.
//  Copyright © 2017 Steven Santiago. All rights reserved.
//GOod

import UIKit


class CreateIntervalTrainerVC: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    

    
 
   
    @IBOutlet weak var timerName: UITextField!
    @IBOutlet weak var numberOfSets: UITextField!
    @IBOutlet weak var activeTime: UIPickerView!
    @IBOutlet weak var restTime: UIPickerView!
    @IBOutlet weak var menuStackView: UIStackView!
    @IBOutlet weak var createBtn: UIButton!
    
    
    var activeClock = Timers(name:"Timer1",hour: 0, minute: 0, second: 0, restTime: 0, activeTime: 0, currentRunTime: 0, sets: 0)
    var restClock = Timers(name:"Timer2",hour: 0, minute: 0, second: 0, restTime: 0, activeTime: 0, currentRunTime: 0, sets: 0) // really only need to store h,m,s
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController!.navigationBar.isHidden = false
        //Call from extension that closes keyboard
        self.hideKeyboardWhenTappedAround()
        activeTime.tag = 1
        activeTime.delegate = self
        activeTime.dataSource = self
        restTime.tag = 2
        restTime.delegate = self
        restTime.dataSource = self
        createBtn.isEnabled = false
//        menuStackView.setCustomSpacing(<#T##spacing: CGFloat##CGFloat#>, after: <#T##UIView#>)
        // Do any additional setup after loading the view.
        
        
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
        
        switch component {
        case 0:
            if pickerView.tag == 1{
                activeClock.hour = row
                activeClock.activeTime = addTime(hours: activeClock.hour, minutes: activeClock.minute, seconds: activeClock.second)
                activeClock.currentRunTime = activeClock.activeTime
                validUserInput()
            } else {
                restClock.hour = row
                activeClock.restTime = addTime(hours: restClock.hour, minutes: restClock.minute, seconds: restClock.second)
                validUserInput()
                
            }
        case 1:
            if pickerView.tag == 1{
                activeClock.minute = row
                activeClock.activeTime = addTime(hours: activeClock.hour, minutes: activeClock.minute, seconds: activeClock.second)
                activeClock.restTime = addTime(hours: restClock.hour, minutes: restClock.minute, seconds: restClock.second)
                activeClock.currentRunTime = activeClock.activeTime
                validUserInput()
            } else {
                restClock.minute = row
                activeClock.restTime = addTime(hours: restClock.hour, minutes: restClock.minute, seconds: restClock.second)
                validUserInput()
            }
        case 2:
            if pickerView.tag == 1{
                activeClock.second = row
                activeClock.activeTime = addTime(hours: activeClock.hour, minutes: activeClock.minute, seconds: activeClock.second)
                activeClock.currentRunTime = activeClock.activeTime
                validUserInput()
            } else {
                restClock.second = row
                activeClock.restTime = addTime(hours: restClock.hour, minutes: restClock.minute, seconds: restClock.second)
                validUserInput()
            }
        default:
            break;
        }
    }
    
    func addTime(hours:Int,minutes:Int,seconds:Int) -> Int {
    return Int((hours*60*60) + (minutes*60) + (seconds))
    }
    
    @IBAction func checkInput(_ sender: UITextField) {
        validUserInput()
    }
    func validUserInput(){
        if(numberOfSets.text?.isEmpty == false && activeClock.activeTime != 0 && activeClock.restTime != 0){
            createBtn.isEnabled = true
            activeClock.sets = Int(numberOfSets.text!)!
        } else {
        createBtn.isEnabled = false
        }
    }
    
    
    
    func save(){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else{return}
        let intervalT = IntervalTimer(context: managedContext)
        intervalT.activeTime = Int32(activeClock.activeTime)
        intervalT.name = activeClock.name
        intervalT.restTime = Int32(activeClock.restTime)
        intervalT.sets = Int16(activeClock.sets)
        appDelegate?.saveContext()
    }
    
    

}
