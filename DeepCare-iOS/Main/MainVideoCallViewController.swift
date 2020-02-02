//
//  MainVideoCallViewController.swift
//  DeepCare-iOS
//
//  Created by Suji Kim on 2/1/20.
//  Copyright © 2020 sjkim. All rights reserved.
//

import UIKit
import AVFoundation
import FirebaseStorage

class MainVideoCallViewController: UIViewController {

    @IBOutlet weak var frontCameraView: UIView!
    @IBOutlet weak var talkerNameLabel: UILabel!
    @IBOutlet weak var talkerView: UIView!
    
    var session: AVCaptureSession?
    var input: AVCaptureDeviceInput?
    var output: AVCaptureStillImageOutput?
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    var data: Person?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        talkerNameLabel.text = data?.name
        openCamera()
        fetchVideo()
        
        let audioSession = AVAudioSession.sharedInstance()

        do {
            try audioSession.setCategory(AVAudioSession.Category.playAndRecord, mode: .spokenAudio, options: .defaultToSpeaker)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("error.")
        }  
    }
    
    func fetchVideo() {
        let videoURL = URL(string: "https://firebasestorage.googleapis.com/v0/b/deepcare-ios.appspot.com/o/Actual%2FElon.mp4?alt=media&token=56e58236-6ff0-408b-82a5-ed0ddac0526b")
        
        let asset = AVAsset(url: videoURL!)
        let playerItem = AVPlayerItem(asset: asset)
        let player = AVPlayer(playerItem: playerItem)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = talkerView.bounds //bounds of the view in which AVPlayer should be displayed
//        playerLayer.frame.size.height = talkerView.bounds.height
        playerLayer.videoGravity = .resizeAspectFill
        talkerView.layer.addSublayer(playerLayer)
        player.volume = 10
        player.isMuted = false
        player.play()
        
    }
    
    @IBAction func hungUpButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func getDevice(position: AVCaptureDevice.Position) -> AVCaptureDevice? {
        let devices: NSArray = AVCaptureDevice.devices() as NSArray;
        for de in devices {
            let deviceConverted = de as! AVCaptureDevice
            if(deviceConverted.position == position){
               return deviceConverted
            }
        }
       return nil
    }
    
    func openCamera() {
        //Initialize session an output variables this is necessary
        session = AVCaptureSession()
        output = AVCaptureStillImageOutput()
        let camera = getDevice(position: .front)
        do {
            input = try AVCaptureDeviceInput(device: camera!)
        } catch let error as NSError {
           print(error)
           input = nil
        }
        if(session?.canAddInput(input!) == true){
            session?.addInput(input!)
           output?.outputSettings = [AVVideoCodecKey : AVVideoCodecJPEG]
            if(session?.canAddOutput(output!) == true){
                session?.addOutput(output!)
                previewLayer = AVCaptureVideoPreviewLayer(session: session!)
                previewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
                previewLayer?.connection!.videoOrientation = AVCaptureVideoOrientation.portrait
              previewLayer?.frame = frontCameraView.bounds
              frontCameraView.layer.addSublayer(previewLayer!)
              session?.startRunning()
           }
        }
    }
}
