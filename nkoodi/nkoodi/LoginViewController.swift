//
//  LoginViewController.swift
//  nkoodi
//
//  Created by Shimaa Magdi on 8/1/18.
//  Copyright © 2018 Hajj Hackathon. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if Auth.auth().currentUser == nil {
            Auth.auth().signIn(withEmail: "shimaa.magdi@yahoo.com", password: "") { (result, error) in
                
            }
        }
        
    }
    
    
}
