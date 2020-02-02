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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationController?.hidesBarsOnTap = true
        // Do any additional setup after loading the view.
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
