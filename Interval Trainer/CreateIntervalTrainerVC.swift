//
//  CreateIntervalTrainerVC.swift
//  Interval Trainer
// Has user create interval timer settings
//  Created by Steven Santiago on 3/4/17.
//  Copyright © 2017 Steven Santiago. All rights reserved.
//

import UIKit

class CreateIntervalTrainerVC: UIViewController {
 
   
    @IBOutlet weak var numberOfSets: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController!.navigationBar.isHidden = false
        //Call from extension that closes keyboard
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    
    

}
