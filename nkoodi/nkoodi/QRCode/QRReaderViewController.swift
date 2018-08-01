//
//  QRReaderViewController.swift
//  nkoodi
//
//  Created by marko nazmy on 8/2/18.
//  Copyright © 2018 Hajj Hackathon. All rights reserved.
//

import Foundation
import UIKit

class QRReaderViewController: UIViewController {
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var transferContactNameLabel: UILabel!
    @IBOutlet weak var qrCodeTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    
    public static func create() -> QRReaderViewController {
        return UIStoryboard(name: "QRReader", bundle: Bundle.main).instantiateViewController(withIdentifier: String(describing: self)) as! QRReaderViewController
    }
    
    @IBAction func camerButtonTapped(_ sender: Any) {
        let vc = QRCodeReaderViewController.create()
        vc.qrReadingCompletion = {[weak self] token in
            self?.qrCodeTextField.text = token
        }
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func contactsButtonTapped(_ sender: Any) {
    }
    
    @IBAction func transferButtonTapped(_ sender: Any) {
        
        let alert = UIAlertController(title: "Confirmation", message: "Are you sure you want to procced?", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
            }}))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
            }}))
        self.present(alert, animated: true, completion: nil)
    }
}

