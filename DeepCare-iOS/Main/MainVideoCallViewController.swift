//
//  MainVideoCallViewController.swift
//  DeepCare-iOS
//
//  Created by Suji Kim on 2/1/20.
//  Copyright © 2020 sjkim. All rights reserved.
//

import UIKit
import AVFoundation

class MainVideoCallViewController: UIViewController {

    @IBOutlet weak var frontCameraView: UIView!
    
    var session: AVCaptureSession?
    var input: AVCaptureDeviceInput?
    var output: AVCaptureStillImageOutput?
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        openCamera()
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
