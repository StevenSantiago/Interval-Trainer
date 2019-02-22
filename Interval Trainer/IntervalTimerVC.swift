//
//  QuickStartVC.swift
//  Interval Trainer
//
//  Created by Steven Santiago on 3/4/17.
//  Copyright © 2017 Steven Santiago. All rights reserved.
//TODO: 1.Find better name for controller. DONE!
//      2.Keep Cleaning up code to follow MVC and reduce redundancy
//      3.Fix the constant resizing of the timerlbl on certain number. Will need a model file to focus on this

import UIKit
import AVFoundation


class IntervalTimerVC: UIViewController {

    @IBOutlet var TimerBackView: UIView!
    @IBOutlet weak var timerLbl: UILabel!
    @IBOutlet weak var StartResumeBtn: UIButton!
    @IBOutlet weak var StopBtn: UIButton!
    @IBOutlet weak var numberOfSets: UILabel!
    
    var intervalTimer = Timers(hour: 0, minute: 0, second: 45, restTime: 12, activeTime: 45, currentRunTime: 45, sets: 10)
    
    var HMS:(Int,Int,Int) = (0,0,0)
    
    var timer = Timer()
    var active = true
    var audioPlayer = AVAudioPlayer()
    var audioPlayer2 = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.isIdleTimerDisabled = true
        //UIFont.monospacedDigitSystemFont(ofSize: 45.0, weight: .medium)

        navigationController!.navigationBar.isHidden = false
        timerLbl.text = String(intervalTimer.minute) + ":" + String(format: "%02d",intervalTimer.second)
        timerLbl.adjustsFontSizeToFitWidth = false
        let originalFont = UIFont(name: "Laserian", size: 45)
        var originalFontDescriptor = originalFont!.fontDescriptor
        print(originalFontDescriptor)

        let fontDescriptorFeatureSettings = [
            [
                UIFontDescriptor.FeatureKey.featureIdentifier: kNumberSpacingType,
                UIFontDescriptor.FeatureKey.typeIdentifier: kMonospacedNumbersSelector
            ]
        ]
        
        let fontDescriptorFeatureSettingsT = [
            [
                UIFontDescriptor.FeatureKey.featureIdentifier:kAllTypographicFeaturesType,
                UIFontDescriptor.FeatureKey.typeIdentifier: kAllTypeFeaturesOnSelector
            ]
        ]

        let fontDescriptorAttributes = [UIFontDescriptor.AttributeName.featureSettings: fontDescriptorFeatureSettings]
        originalFontDescriptor = originalFontDescriptor.addingAttributes(fontDescriptorAttributes)
        originalFontDescriptor = originalFontDescriptor.addingAttributes([UIFontDescriptor.AttributeName.featureSettings: fontDescriptorFeatureSettingsT])
        let fontDescriptor = originalFontDescriptor
        
        print(fontDescriptor)
        
        let font = UIFont(descriptor: fontDescriptor, size: 0.0)

        timerLbl.font = font
        
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
        if(active){
        intervalTimer.subtractRunTime()
        if(intervalTimer.currentRunTime != 0){
            updateTimerLbl()
        }
        if intervalTimer.currentRunTime == 0 && intervalTimer.sets > 0{
                    intervalTimer.subtractSet()
                    numberOfSets.text = String(intervalTimer.sets)
                    audioPlayer2.play()
                    active = false
                    intervalTimer.resetRestTime()
                    TimerBackView.backgroundColor = #colorLiteral(red: 1, green: 0.2555991, blue: 0.4611244713, alpha: 1)
                    updateTimerLbl()
                    intervalTimer.subtractRunTime()
        }
        else if intervalTimer.currentRunTime > 0 && intervalTimer.sets >= 1{
                    countDownAlert()
        }
    }
        else {
                if(intervalTimer.currentRunTime == 0) {
                    active = true
                    intervalTimer.resetActiveTime()
                    audioPlayer2.play()
                    if(intervalTimer.sets == 0){
                        intervalTimer.endOfSession()
                        timer.invalidate()
                        timerLbl.text = "Complete!"
                        //timerLbl.adjustsFontSizeToFitWidth = true
                        StartResumeBtn.isHidden = false
                    } else{
                        updateTimerLbl()
                    }
                    TimerBackView.backgroundColor = #colorLiteral(red: 0.423529923, green: 0.6870478392, blue: 0.8348321319, alpha: 1)
                }
                else if intervalTimer.currentRunTime > 0 {
                    countDownAlert()
                    updateTimerLbl()
                    intervalTimer.subtractRunTime()
                }
        }
    }
    
    func countDownAlert(){
        if (intervalTimer.currentRunTime == 3 || intervalTimer.currentRunTime == 2 || intervalTimer.currentRunTime == 1){
            audioPlayer.play()
        }
    }
    
    func updateTimerLbl(){
        HMS = intervalTimer.convertToHoursMinsSeconds(Seconds: intervalTimer.currentRunTime)
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
    
    
    
}

//extension UIFont {
//
//    var monospacedDigitFont: UIFont {
//        let oldFontDescriptor = fontDescriptor
//        let newFontDescriptor = oldFontDescriptor.monospacedDigitFontDescriptor
//        return UIFont(descriptor: newFontDescriptor, size: 0)
//    }
//
//}
//
//private extension UIFontDescriptor {
//
//    var monospacedDigitFontDescriptor: UIFontDescriptor {
//        let fontDescriptorFeatureSettings = [[UIFontDescriptor.FeatureKey.featureIdentifier: kNumberSpacingType, UIFontDescriptor.FeatureKey.typeIdentifier: kMonospacedNumbersSelector]]
//        let fontDescriptorAttributes = [UIFontDescriptor.AttributeName.featureSettings: fontDescriptorFeatureSettings]
//        let fontDescriptor = self.addingAttributes(fontDescriptorAttributes)
//        return fontDescriptor
//    }
//
//}
