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
        fetchDataFromFirebase()
        
        let audioSession = AVAudioSession.sharedInstance()

        do {
            try audioSession.setCategory(AVAudioSession.Category.playAndRecord, mode: .spokenAudio, options: .defaultToSpeaker)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("error.")
        }  
    }
    
    func fetchDataFromFirebase() {
        /*
        // Points to the root reference
        let storage = Storage.storage().reference(withPath: "Actual/1.MP4")
        storage.getData(maxSize: 4 * 1024 * 1024) { [weak self](data, error) in
            if let error = error {
                print("Got an error fetching: \(error.localizedDescription)")
                return
            }
            if let data = data {
                print(data)
            }
        }
        */
        let videoURL = URL(string: "https://firebasestorage.googleapis.com/v0/b/deepcare-ios.appspot.com/o/Actual%2F0.MP4?alt=media&token=87b282e7-dd1e-40ea-9628-e7b83e2cfe5e")
        
        let asset = AVAsset(url: videoURL!)
        let playerItem = AVPlayerItem(asset: asset)
        let player = AVPlayer(playerItem: playerItem)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = talkerView.bounds //bounds of the view in which AVPlayer should be displayed
        playerLayer.videoGravity = .resizeAspect
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
