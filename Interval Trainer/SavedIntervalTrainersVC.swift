//
//  SavedIntervalTrainersVC.swift
//  Interval Trainer
//
//  Created by Steven Santiago on 3/4/17.
//  Copyright © 2017 Steven Santiago. All rights reserved.
//

import UIKit

class SavedIntervalTrainersVC: UIViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var savedTimers: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController!.navigationBar.isHidden = false
        savedTimers.dataSource = self
        savedTimers.delegate = self
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TimerCell", for: indexPath) as! SavedTimer
        return cell
    }

}
