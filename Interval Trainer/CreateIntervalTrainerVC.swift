//
//  CreateIntervalTrainerVC.swift
//  Interval Trainer
// Has user create interval timer settings.
//  Created by Steven Santiago on 3/4/17.
//  Copyright © 2017 Steven Santiago. All rights reserved.
//

import UIKit


class CreateIntervalTrainerVC: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    

    
 
   
    @IBOutlet weak var numberOfSets: UITextField!
    @IBOutlet weak var activeTime: UIPickerView!
    @IBOutlet weak var restTime: UIPickerView!
    @IBOutlet weak var menuStackView: UIStackView!
    
    
    var activeClock = Timers(hour: 0,minute: 0,second: 0)
    var restClock = Timers(hour: 0,minute: 0,second: 0)
    
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
//        menuStackView.setCustomSpacing(<#T##spacing: CGFloat##CGFloat#>, after: <#T##UIView#>)
        // Do any additional setup after loading the view.
    }

    @IBAction func startTimer(_ sender: Any) {
        performSegue(withIdentifier: TO_START_TIMER, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? QuickStartVC {
            destination.activeTime = addTime(hours: activeClock.hour, minutes: activeClock.minute, seconds: activeClock.second)
            destination.setsNumber = Int(numberOfSets.text!)!
            destination.restTime = addTime(hours: restClock.hour, minutes: restClock.minute, seconds: restClock.second)
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
            } else {
                restClock.hour = row
            }
        case 1:
            if pickerView.tag == 1{
                activeClock.minute = row
            } else {
                restClock.minute = row
            }
        case 2:
            if pickerView.tag == 1{
                activeClock.second = row
            } else {
                restClock.second = row
            }
        default:
            break;
        }
    }
    
    func addTime(hours:Int,minutes:Int,seconds:Int) -> Double {
    return Double((hours*60*60) + (minutes*60) + (seconds))
    }
    

}
