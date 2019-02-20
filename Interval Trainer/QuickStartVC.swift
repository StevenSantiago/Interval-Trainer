//
//  QuickStartVC.swift
//  Interval Trainer
//
//  Created by Steven Santiago on 3/4/17.
//  Copyright © 2017 Steven Santiago. All rights reserved.
//

import UIKit
import AVFoundation


class QuickStartVC: UIViewController {

    @IBOutlet var TimerBackView: UIView!
    @IBOutlet weak var timerLbl: UILabel!
    @IBOutlet weak var StartResumeBtn: UIButton!
    @IBOutlet weak var StopBtn: UIButton!
    @IBOutlet weak var numberOfSets: UILabel!
    
    var intervalTimer = Timers(hour: 0, minute: 0, second: 0)
    
    var activeTime = 5
    var restTime = 3
    var setsNumber = 4
    
    var timer = Timer()
    var active = true
    var audioPlayer = AVAudioPlayer()
    var audioPlayer2 = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.isIdleTimerDisabled = true
        navigationController!.navigationBar.isHidden = false
        timerLbl.text = String(intervalTimer.minute) + ":" + String(format: "%02d",intervalTimer.second)
        numberOfSets.text = String(intervalTimer.sets)
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
        var HMS:(Int,Int,Int)
        if(active){
        intervalTimer.subtractRunTime()
        if(intervalTimer.currentRunTime != 0){
            HMS = intervalTimer.convertToHoursMinsSeconds(Seconds: intervalTimer.currentRunTime)
            timerLbl.text = String(HMS.1) + ":" + String(format: "%02d",HMS.2)
        }
        
        if intervalTimer.currentRunTime == 0 && intervalTimer.sets > 0{
                    intervalTimer.subtractSet()
                    numberOfSets.text = String(intervalTimer.sets)
                    audioPlayer2.play()
                    active = false
                    intervalTimer.resetRestTime()
                    TimerBackView.backgroundColor = #colorLiteral(red: 1, green: 0.2555991, blue: 0.4611244713, alpha: 1)
                    HMS = intervalTimer.convertToHoursMinsSeconds(Seconds: intervalTimer.currentRunTime)
                    timerLbl.text = String(HMS.1) + ":" + String(format: "%02d",HMS.2)
                    intervalTimer.subtractRunTime()
        }
        else if intervalTimer.currentRunTime > 0 && intervalTimer.sets >= 1{
                    if (intervalTimer.currentRunTime == 3 || intervalTimer.currentRunTime == 2 || intervalTimer.currentRunTime == 1){
                        audioPlayer.play()
                    }
        }
    }
        else {
                if(intervalTimer.currentRunTime == 0) {
                    active = true
                    intervalTimer.resetActiveTime()
                    audioPlayer2.play()
                    if(intervalTimer.sets == 0){
                        intervalTimer.currentRunTime = 0 // move to model
                        timer.invalidate()
                        timerLbl.text = "Complete!"
                        timerLbl.adjustsFontSizeToFitWidth = true
                        StartResumeBtn.isHidden = false
                    } else{
                        HMS = intervalTimer.convertToHoursMinsSeconds(Seconds: intervalTimer.currentRunTime)
                        timerLbl.text = String(HMS.1) + ":" + String(format: "%02d",HMS.2)
                    }
            
                    TimerBackView.backgroundColor = #colorLiteral(red: 0.423529923, green: 0.6870478392, blue: 0.8348321319, alpha: 1)
                }
                else if intervalTimer.currentRunTime > 0 {
                    if (intervalTimer.currentRunTime == 3 || intervalTimer.currentRunTime == 2 || intervalTimer.currentRunTime == 1){
                        audioPlayer.play()
                    }
                    HMS = intervalTimer.convertToHoursMinsSeconds(Seconds: intervalTimer.currentRunTime)
                    timerLbl.text = String(HMS.1) + ":" + String(format: "%02d",HMS.2)
                    intervalTimer.subtractRunTime()
                }
        }
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
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(QuickStartVC.updateTimer), userInfo: nil, repeats: true)
    }
    
    
    
}

