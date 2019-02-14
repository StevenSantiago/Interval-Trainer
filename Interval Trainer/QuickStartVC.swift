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
    
    var activeTime = 5
    var restTime = 3
    var setsNumber = 4
    
    var hour = 0
    var minute = 0
    var seconds = 0
    
    var timer = Timer()
    var time = 0
    var rest = 0
    var active = true
    var sets = 0
    var audioPlayer = AVAudioPlayer()
    var audioPlayer2 = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.isIdleTimerDisabled = true
        navigationController!.navigationBar.isHidden = false
        time = activeTime
        rest = restTime
        sets = setsNumber
        //timerLbl.text = String(format: "%.1f", time)
        timerLbl.text = String(minute) + ":" + String(format: "%02d",seconds)
        numberOfSets.text = String(sets)
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
                var HMS = convertToHoursMinsSeconds(Seconds: time)
                timerLbl.text = String(HMS.1) + ":" + String(format: "%02d",HMS.2)
                if time <= 0 && sets > 0{
                    sets = sets - 1
                    time = activeTime
                    numberOfSets.text = String(sets)
                    audioPlayer2.play()
                    active = false
                    rest = restTime
                    TimerBackView.backgroundColor = #colorLiteral(red: 1, green: 0.2555991, blue: 0.4611244713, alpha: 1)
                }
                 else if time > 0 && sets >= 1{
                    if (time == 3 || time == 2 || time == 1){
                        audioPlayer.play()
                    }
                    time = abs(time - 1)
                }
                
                 
                else {
                    timer.invalidate()
                    //sender.isHidden = true
                    timerLbl.text = "Finished!"
                    timerLbl.adjustsFontSizeToFitWidth = true
                    StartResumeBtn.isHidden = false
                }
            } else {
                    var HMS = convertToHoursMinsSeconds(Seconds: rest)
                    timerLbl.text = String(HMS.1) + ":" + String(format: "%02d",HMS.2)
                    if rest > 0 {
                        if (rest == 3 || rest == 2 || rest == 1){
                            audioPlayer.play()
                        }
                        rest = abs(rest - 1)
                    }
                    else if(rest <= 0) {
                        active = true
                        audioPlayer2.play()
                        TimerBackView.backgroundColor = #colorLiteral(red: 0.423529923, green: 0.6870478392, blue: 0.8348321319, alpha: 1)
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
    
    func convertToHoursMinsSeconds(Seconds:Int) -> (Int,Int,Int) {
        var hours:Int = 0
        var minutes = Int(Seconds/60)
        var seconds:Int = 0
        
        if(Seconds >= 3600){
            //Hours
            hours = 1
        }
        if(Seconds >= 60){
            //Minutes
            minutes = Int(Seconds/60)
            
            seconds = Seconds % 60
        } else {
            seconds = Int(Seconds)
        }
        
        return (hours,minutes,seconds)
    }
    
    func convertToSeconds(h:Int,m:Int,s:Int) -> Int{
        return Int(s + m*60 + h*60*60)
    }
    
    
}


//        let timeString = String(format: "%0.1f", time)
//        if(active){
//        if time > 0.01 && sets >= 1{
//            if (timeString == "3.0" || timeString == "2.0" || timeString == "1.0"){
//                audioPlayer.play()
//            }
//        time = abs(time - 0.1)//FIX negative issue. Double trailling digits causes below to display as negative at 0.1
//        timerLbl.text = String(format: "%.1f", time)
//        }
//        else if time <= 0.01 && sets > 0{
//            sets = sets - 1
//            time = activeTime
//            numberOfSets.text = String(sets)
//            audioPlayer2.play()
//            timerLbl.text = String(format: "%.1f", time)
//            active = false
//            rest = restTime
//            TimerBackView.backgroundColor = #colorLiteral(red: 1, green: 0.2555991, blue: 0.4611244713, alpha: 1)
//        }
//        else {
//            timer.invalidate()
//            //sender.isHidden = true
//            timerLbl.text = "Finished!"
//            timerLbl.adjustsFontSizeToFitWidth = true
//            StartResumeBtn.isHidden = false
//        }
//        }
//        else {
//            rest = abs(rest - 0.1)
//            let restString = String(format: "%0.1f", rest)
//            timerLbl.text = String(format: "%.1f", rest)
//
//            if rest > 0.01 {
//                if (restString == "3.0" || restString == "2.0" || restString == "1.0"){
//                    audioPlayer.play()
//                }
//            }
//            if(rest <= 0.01) {
//                active = true
//                audioPlayer2.play()
//                TimerBackView.backgroundColor = #colorLiteral(red: 0.423529923, green: 0.6870478392, blue: 0.8348321319, alpha: 1)
//            }
//        }
