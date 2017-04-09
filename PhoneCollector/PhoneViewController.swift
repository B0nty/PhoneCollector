//
//  PhoneViewController.swift
//  PhoneCollector
//
//  Created by Jernej Hartman on 07/04/2017.
//  Copyright © 2017 B0nty. All rights reserved.
//

import UIKit

class addPhoneViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBOutlet weak var addUpdateButton: UIButton!
    
    @IBOutlet weak var phoneImage: UIImageView!
    
    @IBOutlet weak var modelLabel: UITextField!
    
    var imagePicker = UIImagePickerController()
    
    var phone: Phones? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        
        if phone != nil {
            phoneImage.image = UIImage(data: phone!.image as Data!)
            modelLabel.text = phone?.model
            
            addUpdateButton.setTitle("Update", for: .normal)
        } else {
            deleteButton.isHidden = true
        }
    
    }


    @IBAction func photosTapped(_ sender: Any) {
        
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
            
            phoneImage.image = image
            imagePicker.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        imagePicker.sourceType = .camera
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func addTapped(_ sender: Any) {
        
        
     if phone != nil {
        phone!.model = modelLabel.text
        phone!.image = UIImagePNGRepresentation(phoneImage.image!) as NSData?

     } else {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let phone = Phones(context: context)
        
        phone.model = modelLabel.text
        phone.image = UIImagePNGRepresentation(phoneImage.image!) as NSData?
        
        }
      
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)

    }
    
    @IBAction func deleteTapped(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        context.delete(phone!)
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
        
    }
}
