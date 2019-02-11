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
    
    var activeTime = 5.0
    var restTime = 3.0
    var setsNumber = 4
    
    var timer = Timer()
    var time = 0.0
    var rest = 0.0
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
        timerLbl.text = String(format: "%.1f", time)
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
        let timeString = String(format: "%0.1f", time)
        if(active){
        if time > 0.01 && sets >= 1{
            if (timeString == "3.0" || timeString == "2.0" || timeString == "1.0"){
                audioPlayer.play()
            }
        time = abs(time - 0.1)//FIX negative issue. Double trailling digits causes below to display as negative at 0.1
        timerLbl.text = String(format: "%.1f", time)
        }
        else if time <= 0.01 && sets > 0{
            sets = sets - 1
            time = activeTime
            numberOfSets.text = String(sets)
            audioPlayer2.play()
            timerLbl.text = String(format: "%.1f", time)
            active = false
            rest = restTime
            TimerBackView.backgroundColor = #colorLiteral(red: 1, green: 0.2555991, blue: 0.4611244713, alpha: 1)
        }
        else {
            timer.invalidate()
            //sender.isHidden = true
            timerLbl.text = "Finished!"
            timerLbl.adjustsFontSizeToFitWidth = true
            StartResumeBtn.isHidden = false
        }
        }
        else {
            rest = abs(rest - 0.1)
            let restString = String(format: "%0.1f", rest)
            timerLbl.text = String(format: "%.1f", rest)
            
            if rest > 0.01 {
                if (restString == "3.0" || restString == "2.0" || restString == "1.0"){
                    audioPlayer.play()
                }
            }
            if(rest <= 0.01) {
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
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(QuickStartVC.updateTimer), userInfo: nil, repeats: true)
    }
}
