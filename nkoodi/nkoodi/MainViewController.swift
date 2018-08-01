//
//  MainViewController.swift
//  nkoodi
//
//  Created by Shimaa Magdi on 8/1/18.
//  Copyright © 2018 Hajj Hackathon. All rights reserved.
//

import UIKit
import QRCode

class MainViewController: UIViewController {
    
    @IBOutlet weak var qrCodeImageView: UIImageView!
    var userCode :String = "N55Test"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        qrCodeImageView.image = {
            var qrCode = QRCode(userCode)!
            qrCode.size = self.qrCodeImageView.bounds.size
            qrCode.color = CIColor(rgba: "16a085")
            qrCode.backgroundColor = CIColor(rgba: "000")
            return qrCode.image
        }()
        
    }
    
    
    
    
}
