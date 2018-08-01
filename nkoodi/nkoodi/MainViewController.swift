//
//  MainViewController.swift
//  nkoodi
//
//  Created by Shimaa Magdi on 8/1/18.
//  Copyright © 2018 Hajj Hackathon. All rights reserved.
//

import UIKit
import QRCode
import FirebaseAuth
import FirebaseDatabase

class MainViewController: UIViewController {
    
    @IBOutlet weak var qrCodeImageView: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblCode: UILabel!
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUserData()
    }
    
    
    
    static func create(){
        
    }
    private func setUpUserData() {
        ref = Database.database().reference()
        if let userID = Auth.auth().currentUser?.uid{
            let userData = ref.child("users").child(userID)
            userData.child("qr").observeSingleEvent(of: .value, with: { snapShot in
                if let qrCode = snapShot.value as? String{
                    self.lblCode.text = qrCode
                    self.qrCodeImageView.image = {
                        var qrCode = QRCode(qrCode)!
                        qrCode.size = self.qrCodeImageView.bounds.size
                        qrCode.color = CIColor(rgba: "16a085")
                        qrCode.backgroundColor = CIColor(rgba: "000")
                        return qrCode.image
                    }()
                }
            })
            
            userData.child("name").observeSingleEvent(of: .value, with: { snapShot in
                if let username = snapShot.value as? String{
                    self.lblName.text = username
                }
            })
        }
    }
    
}