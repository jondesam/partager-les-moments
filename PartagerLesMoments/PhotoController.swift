//
//  PhotoController.swift
//  Partager les moments
//
//  Created by MyMac on 18-08-12.
//  Copyright © 2018 Apex. All rights reserved.
//

import UIKit

class PhotoController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {

    @IBOutlet weak var partagerButton: UIBarButtonItem!
    @IBOutlet weak var photoAPartager: UIImageView!
    @IBOutlet weak var texteAPartager: UITextView!
    
    let texteVide = "Entrez un Texte..."
    var objectOfUiImagePickerController : UIImagePickerController?
    
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
        
        objectOfUiImagePickerController = UIImagePickerController.init()
        objectOfUiImagePickerController?.delegate = self
        objectOfUiImagePickerController?.allowsEditing = true
        
        texteAPartager.delegate = self
        
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        objectOfUiImagePickerController?.dismiss(animated: true, completion: nil)
       // picker.dismiss(animated: <#T##Bool#>, completion: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var image: UIImage?
        
        if let editee = info[UIImagePickerControllerEditedImage] as? UIImage{
            image = editee
        } else if let original = info[UIImagePickerControllerOriginalImage] as? UIImage{
            image = original
        }
        photoAPartager.image = image
        objectOfUiImagePickerController?.dismiss(animated: true, completion: nil)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == texteVide {
            textView.text = ""
        }
    }
    
    @objc func prendrePhoto(){
       
        guard objectOfUiImagePickerController != nil else {return}
   
        //actionSheet definition
        let actionSheet = UIAlertController(title: "Prendre photo?", message: "Choisir le média", preferredStyle: .actionSheet)
        
       //Start//definition of each element of actionSheet//
        let apprareil = UIAlertAction(title: "Appareil photo", style: .default) { (act) in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                self.objectOfUiImagePickerController?.sourceType = .camera
                self.present(self.objectOfUiImagePickerController!, animated: true, completion: nil)
            }
        }
        
        let librairie = UIAlertAction(title: "Librairie photo", style: .default) { (act) in
                self.objectOfUiImagePickerController?.sourceType = .photoLibrary
                self.present(self.objectOfUiImagePickerController!, animated: true, completion: nil)
        }
        
        let annuler = UIAlertAction(title: "Annuler", style: .cancel, handler: nil)
         //End//definition of each element of actionSheet//
        
        ///added option///
//        let kdfj = UIAlertAction(title: "4th option", style: .default) { (ㅋㅋ) in
//            self.objectOfUiImagePickerController?.sourceType = .savedPhotosAlbum
//            self.present(self.objectOfUiImagePickerController!, animated: true, completion: nil)
//        }
        ///added option///
        
        ///adding elemetns of actionSheet
        actionSheet.addAction(apprareil)
        actionSheet.addAction(librairie)
        actionSheet.addAction(annuler)
        //actionSheet.addAction(kdfj)
        
        ///iPad////
        if UIDevice.current.userInterfaceIdiom == .pad {
            if let pop = actionSheet.popoverPresentationController {
                pop.sourceView = self.view
                pop.sourceRect = CGRect(x: self.view.frame.midX, y: self.view.frame.midY, width: 0, height: 0)
                pop.permittedArrowDirections = []
            }
        }
        //line that excutes when button press//
        self.present(actionSheet, animated: true, completion: nil)
    }

    @IBAction func boutonPartageAppute(_ sender: Any) {
        
        var contenuAPartager: [Any] = [Any].init()
        
        if let image = photoAPartager.image, image != #imageLiteral(resourceName: "Superman-facebook.svg") {
            contenuAPartager.append(image)
        }
        
        if texteAPartager.text != "", texteAPartager.text != texteVide {
            contenuAPartager.append(texteAPartager.text)
        }
        
        let activity = UIActivityViewController(activityItems: contenuAPartager, applicationActivities: nil)
        if UIDevice.current.userInterfaceIdiom == .pad {
            if let pop = activity.popoverPresentationController {
                pop.sourceView = self.view
                pop.sourceRect = CGRect(x: self.view.frame.midX, y: self.view.frame.midY, width: 0, height: 0)
                pop.permittedArrowDirections = []
            }
        }
            //line that excutes when button press//
        self.present(activity, animated: true) {
            self.miseEnPlace()
        }

    }
    
}
