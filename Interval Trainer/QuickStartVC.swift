//
//  QuickStartVC.swift
//  Interval Trainer
//
//  Created by Steven Santiago on 3/4/17.
//  Copyright © 2017 Steven Santiago. All rights reserved.
//

import UIKit

class QuickStartVC: UIViewController {

    @IBOutlet weak var timerLbl: UILabel!
    @IBOutlet weak var StartResumeBtn: UIButton!
    @IBOutlet weak var StopBtn: UIButton!
    @IBOutlet weak var numberOfSets: UILabel!
    
    var timer = Timer()
    var time = 5.0
    var sets = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController!.navigationBar.isHidden = false
        timerLbl.text = String(format: "%.1f", time)
        numberOfSets.text = String(sets)
        StartResumeBtn.setTitle("START", for: .normal)
        StartResumeBtn.titleLabel?.sizeToFit()
    }

  
    @objc func updateTimer(){
        if time > 0.01 && sets >= 1{
        time = time - 0.1
        timerLbl.text = String(format: "%.1f", time)
        }
        else if time <= 0.01 && sets > 0{
            sets = sets - 1
            time = 5.0
            numberOfSets.text = String(sets)
            timerLbl.text = String(format: "%.1f", time)
        }
        else {
            timer.invalidate()
            //sender.isHidden = true
            StartResumeBtn.isHidden = false
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
