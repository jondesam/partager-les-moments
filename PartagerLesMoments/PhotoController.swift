//
//  PhotoController.swift
//  Partager les moments
//
//  Created by MyMac on 18-08-12.
//  Copyright © 2018 Apex. All rights reserved.
//

import UIKit

class PhotoController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var partagerButton: UIBarButtonItem!
    @IBOutlet weak var photoAPartager: UIImageView!
    @IBOutlet weak var texteAPartager: UITextView!
    
    let texteVide = "Entrez un Texte..."
    var imagePicker : UIImagePickerController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       miseEnPlace()
    }
    
    func miseEnPlace() {
        photoAPartager.contentMode = .scaleAspectFit
        photoAPartager.image = #imageLiteral(resourceName: "Superman-facebook.svg")
        photoAPartager.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(prendrePhoto))
        photoAPartager.addGestureRecognizer(tap)
        
        texteAPartager.text = texteVide
        
        imagePicker = UIImagePickerController()
        imagePicker?.delegate = self
        imagePicker?.allowsEditing = true
        
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePicker?.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var image: UIImage?
        
        if let editee = info[UIImagePickerControllerEditedImage] as? UIImage{
            image = editee
        } else if let original = info[UIImagePickerControllerOriginalImage] as? UIImage{
            image = original
        }
        photoAPartager.image = image
        imagePicker?.dismiss(animated: true, completion: nil)
        
    }
    
    @objc func prendrePhoto(){
        guard imagePicker != nil else {return}
        
        let alerte = UIAlertController(title: "Prendre photo?", message: "Choisir le média", preferredStyle: .actionSheet)
        
        let apprareil = UIAlertAction(title: "Appareil photo", style: .default) { (act) in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                self.imagePicker?.sourceType = .camera
                self.present(self.imagePicker!, animated: true, completion: nil)
            }
        }
        
        let librairie = UIAlertAction(title: "Librairie photo", style: .default) { (act) in
                self.imagePicker?.sourceType = .photoLibrary
                self.present(self.imagePicker!, animated: true, completion: nil)
        }
        
        let annuler = UIAlertAction(title: "Annuler", style: .cancel, handler: nil)
        
        alerte.addAction(apprareil)
        alerte.addAction(librairie)
        alerte.addAction(annuler)
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            if let pop = alerte.popoverPresentationController {
                pop.sourceView = self.view
                pop.sourceRect = CGRect(x: self.view.frame.midX, y: self.view.frame.midY, width: 0, height: 0)
                pop.permittedArrowDirections = []
            }
            
        }
        self.present(alerte, animated: true, completion: nil)
    }

    
    
    @IBAction func boutonPartageAppute(_ sender: Any) {
    }
    
}
