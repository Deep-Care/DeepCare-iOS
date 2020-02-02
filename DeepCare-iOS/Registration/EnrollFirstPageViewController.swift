//
//  EnrollFirstPageViewController.swift
//  DeepCare-iOS
//
//  Created by Param Bole on 2/1/20.
//  Copyright © 2020 sjkim. All rights reserved.
//

import UIKit

class EnrollFirstPageViewController: UIViewController {

    @IBOutlet weak var emergencyButton: UIButton!
    @IBOutlet weak var privacyButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        nameTextField.attributedPlaceholder = NSAttributedString(string: "add your name.", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.4745098039, green: 0.4745098039, blue: 0.4745098039, alpha: 1)])
    }
    
    
    @IBAction func onClickEmergency(_ sender: Any) {
        emergencyButton.setImage(UIImage(named: "icChecked"), for: .normal)
    }
    

    @IBAction func onClickPrivacy(_ sender: Any) {
        privacyButton.setImage(UIImage(named: "icChecked"), for: .normal)
    }
    
    @IBAction func nextStep(_ sender: Any) {
        performSegue(withIdentifier: "nextController", sender: self)
    }

}

extension EnrollFirstPageViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        return true
    }
}
