//
//  MainPhoneCallViewController.swift
//  DeepCare-iOS
//
//  Created by Suji Kim on 2/2/20.
//  Copyright © 2020 sjkim. All rights reserved.
//

import UIKit

class MainPhoneCallViewController: UIViewController {

    @IBOutlet weak var talkerImageView: UIImageView!
    @IBOutlet weak var talkerNameLabel: UILabel!
    
    var data:Person?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        talkerNameLabel.text = data?.name
        talkerImageView.image = UIImage(named: data!.image)
    }
    
    @IBAction func hungUpButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
