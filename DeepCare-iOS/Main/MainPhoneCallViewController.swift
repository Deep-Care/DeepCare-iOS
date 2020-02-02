//
//  MainPhoneCallViewController.swift
//  DeepCare-iOS
//
//  Created by Suji Kim on 2/2/20.
//  Copyright © 2020 sjkim. All rights reserved.
//

import UIKit
import FirebaseStorage
import AVFoundation

class MainPhoneCallViewController: UIViewController {

    @IBOutlet weak var talkerImageView: UIImageView!
    @IBOutlet weak var talkerNameLabel: UILabel!
    
    var data:Person?
    private var audioPlayer: AVPlayer?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        talkerNameLabel.text = data?.name
        talkerImageView.image = UIImage(named: data!.image)
        
        let audioSession = AVAudioSession.sharedInstance()

        do {
            try audioSession.setCategory(AVAudioSession.Category.playAndRecord, mode: .spokenAudio, options: .defaultToSpeaker)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("error.")
        }  
        
        guard let audioURL = URL(string: "https://firebasestorage.googleapis.com/v0/b/deepcare-ios.appspot.com/o/Audio%2F0.wav?alt=media&token=280e573e-029f-41aa-b8f9-8fe4a8d07dd2") else { return }
        
        audioPlayer = AVPlayer(url: audioURL as URL)
        audioPlayer?.isMuted = false
        audioPlayer?.play()
    }
    
    @IBAction func hungUpButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
