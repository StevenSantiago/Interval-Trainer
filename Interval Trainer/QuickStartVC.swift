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
    
    var timer = Timer()
    var time = 0.00
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController!.navigationBar.isHidden = false
        setTimer()
    }

  
    @objc func updateTimer(){
        time = time + 0.01
        timerLbl.text = String(time)
    }
    @IBAction func stopTimer(_ sender: Any) {
        timer.invalidate()
    }
    
    @IBAction func resumeTimer(_ sender: Any) {
        setTimer()
    }
    
    func setTimer(){
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(QuickStartVC.updateTimer), userInfo: nil, repeats: true)
    }
}
