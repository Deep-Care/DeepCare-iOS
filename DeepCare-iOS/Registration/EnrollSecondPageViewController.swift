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
    @IBOutlet weak var imageButton: UIButton!
    @IBOutlet weak var threeOvalImageView: UIImageView!
    @IBOutlet weak var getStartedButton: UIButton!
    
    var defaultImageButton:UIImage?
    var defaultVideoButton:UIImage?
    let imagePickerController = UIImagePickerController()
    var imageSetted = false
    var textFieldFilled = false
    var imageButtonIsPressed = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerController.delegate = self
        talkerNameTextField.delegate = self
        talkerNameTextField.attributedPlaceholder = NSAttributedString(string: "add the talker’s name", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.4745098039, green: 0.4745098039, blue: 0.4745098039, alpha: 1)])
        
        defaultImageButton = imageButton.currentImage
        defaultVideoButton = videoButton.currentImage
    }
    
    @IBAction func chooseImageButtonAction(_ sender: Any) {
        imageButtonIsPressed = true
        imagePickerController.sourceType = .photoLibrary
        self.present(imagePickerController, animated: true, completion: nil)
    }
    @IBAction func chooseVideoButtonAction(_ sender: Any) {
        imageButtonIsPressed = false
        imagePickerController.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
}

extension EnrollSecondPageViewController {
    func checkAllSetted() {
        if imageSetted && textFieldFilled {
            videoLabel.isHidden = false
            videoButton.isHidden = false
            threeOvalImageView.image = UIImage(named: "icThreeOvalY")
            getStartedButton.isEnabled = true
            getStartedButton.setImage(UIImage(named: "btGetStartedY"), for: .normal)
        }
        else {
            videoLabel.isHidden = true
            videoButton.isHidden = true
            threeOvalImageView.image = UIImage(named: "icThreeOvalN")
            getStartedButton.isEnabled = false
            getStartedButton.setImage(UIImage(named: "btGetStartedG"), for: .normal)
        }
        
    }
}

extension EnrollSecondPageViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        talkerNameTextField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if talkerNameTextField.text != "" {
            textFieldFilled = true
        }
        else {
            textFieldFilled = false
        }
        
        checkAllSetted()
    }
}

extension EnrollSecondPageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let getType = info[UIImagePickerController.InfoKey.mediaType] as! String
        if getType == "public.image" && imageButtonIsPressed {
            let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            
            imageButton.setImage(image, for: .normal)
            imageButton.imageView?.contentMode = UIView.ContentMode.scaleAspectFill
            imageButton.cornerRadius = 60
            imageButton.borderWidth = 2
            imageButton.borderColor = #colorLiteral(red: 0.3803921569, green: 0.2980392157, blue: 0.1843137255, alpha: 1)
            imageSetted = true
            
            checkAllSetted()
        }
        else if getType == "public.movie" && !imageButtonIsPressed {
            videoButton.setImage(UIImage(named: "btAdded"), for: .normal)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        if imageButton.currentImage == defaultImageButton {
            imageSetted = false
        }
        checkAllSetted()
        
        if videoButton.currentImage == defaultVideoButton {
            videoButton.setImage(UIImage(named: "btAddVideoN"), for: .normal)
        }
        picker.dismiss(animated: true, completion: nil)
    }
}

