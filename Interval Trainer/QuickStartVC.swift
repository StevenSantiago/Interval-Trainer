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

    @IBOutlet weak var timerLbl: UILabel!
    @IBOutlet weak var StartResumeBtn: UIButton!
    @IBOutlet weak var StopBtn: UIButton!
    @IBOutlet weak var numberOfSets: UILabel!
    
    var timer = Timer()
    var time = 5.0
    var rest = 8.0
    var active = true
    var sets = 10
    var audioPlayer = AVAudioPlayer()
    var audioPlayer2 = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController!.navigationBar.isHidden = false
        timerLbl.text = String(format: "%.1f", time)
        numberOfSets.text = String(sets)
        StartResumeBtn.setTitle("START", for: .normal)
        StartResumeBtn.titleLabel?.sizeToFit()
        
        let repetitionEndSound = Bundle.main.path(forResource: "beep-07", ofType: "wav")
        let setEndSound = Bundle.main.path(forResource: "beep-04", ofType: "wav")
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: repetitionEndSound!))
            audioPlayer2 = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: setEndSound!))
        }
        catch{
            print("error")
        }
    }

  
    @objc func updateTimer(){
        var timeString = String(format: "%0.1f", time)
        if(active){
        if time > 0.01 && sets >= 1{
            if (timeString == "3.0" || timeString == "2.0" || timeString == "1.0"){
                audioPlayer.play()
            }
        time = time - 0.1
        timerLbl.text = String(format: "%.1f", time)
        }
        else if time <= 0.01 && sets > 0{
            sets = sets - 1
            time = 5.0
            numberOfSets.text = String(sets)
            audioPlayer2.play()
            timerLbl.text = String(format: "%.1f", time)
            active = false
            rest = 10
        }
        else {
            timer.invalidate()
            //sender.isHidden = true
            StartResumeBtn.isHidden = false
        }
        }
        else {
            timerLbl.text = String(format: "%.1f", rest)
            rest = rest - 0.1
            if(rest <= 0.01) {
                active = true
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
