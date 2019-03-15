//
//  QuickStartVC.swift
//  Interval Trainer
//
//  Created by Steven Santiago on 3/4/17.
//  Copyright © 2017 Steven Santiago. All rights reserved.


import UIKit
import AVFoundation
import CoreData

//TODO: NEED TO Invalidate timer when backing out of controller after timer has started.

class IntervalTimerVC: UIViewController {

    @IBOutlet var TimerBackView: UIView!
    @IBOutlet weak var timerLbl: UILabel!
    @IBOutlet weak var StartResumeBtn: UIButton!
    @IBOutlet weak var StopBtn: UIButton!
    @IBOutlet weak var numberOfSets: UILabel!
    
    var intervalTimer = Timers(name:"Empty", restTime: 12, activeTime: 45, sets: 10)
    
    
    var HMS:(Int,Int,Int) = (0,0,0)
    var defaultTimer = false;
    var currentRunTime = 45;
    var customLabel = DisplayTimer()
    var timer = Timer()
    var active = true
    var audioPlayer = AVAudioPlayer()
    var audioPlayer2 = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.isIdleTimerDisabled = true
        navigationController!.navigationBar.isHidden = false
        if(defaultTimer == true){
            setDefaultTimer()
        } else{
            currentRunTime = intervalTimer.activeTime
        }
        customLabel = timerLbl as! DisplayTimer
        updateTimerLbl()
        timerLbl.adjustsFontSizeToFitWidth = false
        
        numberOfSets.text = String(intervalTimer.sets)
        StopBtn.isHidden = true
        StartResumeBtn.setTitle("START", for: .normal)
        StartResumeBtn.titleLabel?.sizeToFit()
        let repetitionEndSound = Bundle.main.path(forResource: "beep-07", ofType: "wav")
        let setEndSound = Bundle.main.path(forResource: "beep-04", ofType: "wav")
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: repetitionEndSound!))
            audioPlayer2 = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: setEndSound!))
            
            try? AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.ambient, mode: .default, options: [])
            try? AVAudioSession.sharedInstance().setActive(true) 
        }
        catch{
            print("error")
        }
    }

  
    @objc func updateTimer(){
        if(active){
            currentRunTime = currentRunTime - 1
        if(currentRunTime != 0){
            updateTimerLbl()
        }
        if currentRunTime == 0 && intervalTimer.sets > 0{
                    intervalTimer.subtractSet()
                    numberOfSets.text = String(intervalTimer.sets)
                    audioPlayer2.play()
                    active = false
                    currentRunTime = intervalTimer.restTime
                    TimerBackView.backgroundColor = #colorLiteral(red: 1, green: 0.2555991, blue: 0.4611244713, alpha: 1)
                    updateTimerLbl()
                    currentRunTime = currentRunTime - 1
        }
        else if currentRunTime > 0 && intervalTimer.sets >= 1{
                    countDownAlert()
        }
    }
        else {
                if(currentRunTime == 0) {
                    active = true
                    currentRunTime = intervalTimer.activeTime
                    audioPlayer2.play()
                    if(intervalTimer.sets == 0){
                        currentRunTime = 0
                        timer.invalidate()
                        timerLbl.text = "Complete!"
                        customLabel.updateLabel()
                        StopBtn.isHidden = true
                    } else{
                        updateTimerLbl()
                    }
                    TimerBackView.backgroundColor = #colorLiteral(red: 0.423529923, green: 0.6870478392, blue: 0.8348321319, alpha: 1)
                }
                else if currentRunTime > 0 {
                    countDownAlert()
                    updateTimerLbl()
                    currentRunTime = currentRunTime - 1
                }
        }
    }
    
    func countDownAlert(){
        if (currentRunTime == 3 || currentRunTime == 2 || currentRunTime == 1){
            audioPlayer.play()
        }
    }
    
    func updateTimerLbl(){
        HMS = intervalTimer.convertToHoursMinsSeconds(Seconds: currentRunTime)
        timerLbl.text = String(HMS.1) + ":" + String(format: "%02d",HMS.2)
    }
    
    @IBAction func stopTimer(_ sender: UIButton) {
        timer.invalidate()
        sender.isHidden = true
        StartResumeBtn.isHidden = false
    }
    
    @IBAction func resumeTimer(_ sender: UIButton) {
        setTimer()
        StopBtn.isHidden = false
        sender.isHidden = true
        sender.setTitle("RESUME", for: .normal)
    }
    

    func setTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(IntervalTimerVC.updateTimer), userInfo: nil, repeats: true)
    }
    
    func setDefaultTimer(){
        let fetchRequest: NSFetchRequest<IntervalTimer> = IntervalTimer.fetchRequest()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        do{
            let fetchResults = try context.fetch(fetchRequest) as [NSManagedObject]
            if(fetchResults.count != 0){
            for index in 0...fetchResults.count-1 {
                let managedObject = fetchResults[index]
                let defaultTimer = managedObject.value(forKey: "isDefault") as! Bool
                if(defaultTimer == true){
                    intervalTimer.activeTime = managedObject.value(forKey: "activeTime") as! Int
                    currentRunTime = intervalTimer.activeTime
                    intervalTimer.restTime = managedObject.value(forKey: "restTime") as! Int
                    intervalTimer.sets = managedObject.value(forKey: "sets") as! Int
                    intervalTimer.name = managedObject.value(forKey: "name") as! String
                }
            }
            }
        } catch{
            print(error)
        }
    }
    
    
}


