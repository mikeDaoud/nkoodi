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
    
    var qrCodeTextFieldHasChanged: ((String)->())?
    
    public static func create() -> QRReaderViewController {
        return UIStoryboard(name: "QRReader", bundle: Bundle.main).instantiateViewController(withIdentifier: String(describing: self)) as! QRReaderViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        qrCodeTextField.delegate = self
        qrCodeTextFieldHasChanged = { text in
            self.transferContactNameLabel.text = "user name: " + text
        }
        self.view.backgroundColor = UIColor(hex: 0x00c6c10)
    }
    
    @IBAction func camerButtonTapped(_ sender: Any) {
        let vc = QRCodeReaderViewController.create()
        vc.qrReadingCompletion = {[weak self] token in
            self?.qrCodeTextField.text = token
            self?.qrCodeTextFieldHasChanged?(token)
            self?.amountTextField.becomeFirstResponder()
        }
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func contactsButtonTapped(_ sender: Any) {
    }
    
    @IBAction func transferButtonTapped(_ sender: Any) {
        
        if qrCodeTextField.text == "" || amountTextField.text == "" {
            let alert = UIAlertController(title: "Alert!", message: "you should enter contact and amount", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                switch action.style{
                case .default:
                    print("default")
                    
                case .cancel:
                    print("cancel")
                    
                case .destructive:
                    print("destructive")
                    
                }}))
            self.present(alert, animated: true, completion: nil)
        }else {
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
}

extension QRReaderViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        qrCodeTextFieldHasChanged?(text)
        return true
    }
}
