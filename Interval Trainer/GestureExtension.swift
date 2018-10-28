//
//  GestureExtension.swift
//  Interval Trainer
//This will be used to close keyboards by touching in view
//  Created by Steven on 10/28/18.
//  Copyright © 2018 Steven Santiago. All rights reserved.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        //tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
