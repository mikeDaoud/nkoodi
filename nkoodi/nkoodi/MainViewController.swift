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
import Pastel

class MainViewController: BaseViewController {
    static let ID = "MainViewController"
    @IBOutlet weak var qrCodeImageView: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblCode: UILabel!{
        didSet{
            lblCode.textColor = UIColor(hexString: "#333")
        }
    }
    @IBOutlet weak var balance: UILabel!
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUserData()
        
        
    }
    
    
    static func create() -> MainViewController {
        return UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier:
            MainViewController.ID) as! MainViewController
    }
    
    private func setUpUserData() {
        ref = Database.database().reference()
        if let userID = Auth.auth().currentUser?.uid{
            
            DataStore.shared.ref.child("users").child(userID).child("current_balance").observe(.value, with: {snapShot in
                if let amount = snapShot.value as? Double{
                    self.balance.text = "\(String(amount)) SAR"
                }
            })
            
            
            
            let userData = ref.child("users").child(userID)
            userData.child("qr").observeSingleEvent(of: .value, with: { snapShot in
                if let qrCode = snapShot.value as? String{
                    let attributedString = NSMutableAttributedString(string: qrCode)
                    attributedString.addAttribute(NSKernAttributeName, value: 10, range: NSRange(location: 0, length: attributedString.length - 1))
                    self.lblCode.attributedText = attributedString
                    self.qrCodeImageView.image = {
                        var qrCode = QRCode(qrCode)!
                        qrCode.size = self.qrCodeImageView.bounds.size
                        qrCode.color = CIColor(rgba: "fff")
                        qrCode.backgroundColor = CIColor(rgba: "009efd")
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
    
    // Design
    @IBOutlet weak var nameCard: UIView!{
        didSet{
            nameCard.backgroundColor = .clear
        }
    }
    @IBOutlet weak var qrCard: UIView!{
        didSet{
            qrCard.dropShadow()
        }
    }
    
    
}
