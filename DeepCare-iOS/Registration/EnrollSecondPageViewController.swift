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
    
    let imagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerController.delegate = self
        talkerNameTextField.delegate = self
        talkerNameTextField.attributedPlaceholder = NSAttributedString(string: "add the talker’s name", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.4745098039, green: 0.4745098039, blue: 0.4745098039, alpha: 1)])
    }
    
    @IBAction func chooseImageButtonAction(_ sender: Any) {
        imagePickerController.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
}

extension EnrollSecondPageViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        talkerNameTextField.resignFirstResponder()
        return true
    }
}

extension EnrollSecondPageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        imageButton.setImage(image, for: .normal)
        imageButton.imageView?.contentMode = UIView.ContentMode.scaleAspectFill
        imageButton.cornerRadius = 60
        imageButton.borderWidth = 2
        imageButton.borderColor = #colorLiteral(red: 0.3803921569, green: 0.2980392157, blue: 0.1843137255, alpha: 1)
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
