//
//  EnrollSecondPageViewController.swift
//  DeepCare-iOS
//
//  Created by Param Bole on 2/1/20.
//  Copyright © 2020 sjkim. All rights reserved.
//

import UIKit

class EnrollSecondPageViewController: UIViewController {

    @IBOutlet weak var videoLabel: UILabel!
    @IBOutlet weak var videoButton: UIButton!
    @IBOutlet weak var talkerNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        talkerNameTextField.delegate = self

    }
    

}

extension EnrollSecondPageViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        talkerNameTextField.resignFirstResponder()
        
        return true
    }
}
