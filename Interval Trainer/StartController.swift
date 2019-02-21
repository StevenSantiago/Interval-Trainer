//
//  StartController.swift
//  Interval Trainer
//
//  Created by Steven Santiago on 3/3/17.
//  Copyright © 2017 Steven Santiago. All rights reserved.
// StartController Done for now
//TODO: Work on Quick Start Controller MVC

import UIKit

class StartController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    }

    @IBAction func CreateIntervalTimer(_ sender: Any) {
        performSegue(withIdentifier: TO_CREATE_INTERVAL_TRAINER, sender: nil)
    }
    
    @IBAction func QuickStart(_ sender: Any) {
        performSegue(withIdentifier: TO_INTERVAL_TIMER, sender: nil)
    }
    
    @IBAction func SavedIntervalTimers(_ sender: Any) {
        performSegue(withIdentifier: TO_SAVED_INTERVAL_TRAINER, sender: nil)
    }
    @IBAction func History(_ sender: Any) {
        performSegue(withIdentifier: TO_HISTORY, sender: nil)
    }
    
}

