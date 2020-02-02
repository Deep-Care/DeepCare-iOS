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
    private var audioURLS = [String]()
    private var randNum = [Int]()
    
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
        
        fetchAudios()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        playAudio(audioURLS[0])
        
    }
    
    @IBAction func hungUpButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func playAudio(_ url: String) {
        guard let audioURL = URL(string: url) else { return }
        
        audioPlayer = AVPlayer(url: audioURL as URL)
        audioPlayer?.volume = 30
        audioPlayer?.isMuted = false
        audioPlayer?.play()
    }
    
    private func fetchAudios(){
        audioURLS.append("https://firebasestorage.googleapis.com/v0/b/deepcare-ios.appspot.com/o/Audio%2FElonAudio.mp3?alt=media&token=74e32ec6-49cd-4675-a2d9-8a252c2955f9")
    }
}
