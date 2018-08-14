//
//  PhotoController.swift
//  Partager les moments
//
//  Created by MyMac on 18-08-12.
//  Copyright © 2018 Apex. All rights reserved.
//

import UIKit

class PhotoController: UIViewController {

    @IBOutlet weak var partagerButton: UIBarButtonItem!
    
    @IBOutlet weak var photoAPartager: UIImageView!
    
    @IBOutlet weak var texteAPartager: UITextView!
    
    let texteVide = "Entrez un Texte..."
    
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
    }
    
    @objc func prendrePhoto(){
        
    }

    @IBAction func boutonPartageAppute(_ sender: Any) {
    }
    
}
