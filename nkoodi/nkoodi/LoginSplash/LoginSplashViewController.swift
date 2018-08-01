//
//  LoginSplashViewController.swift
//  nkoodi
//
//  Created by Michael Attia on 8/1/18.
//  Copyright © 2018 Hajj Hackathon. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginSplashViewController: UIViewController {
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var name: UITextField!
    
    @IBAction func login(_ sender: Any) {
        if let email = email.text,
            let pass = password.text{
            Auth.auth().signIn(withEmail: email, password: pass) { (result, err) in
                guard err == nil else {return}
                self.proceedToApp()
            }
        }
    }
    
    @IBAction func register(_ sender: Any) {
        if let email = email.text,
            let pass = password.text{
            Auth.auth().createUser(withEmail: email, password: pass) { (result, err) in
                guard err == nil, let userId = result?.user.uid else {return}
                let user = User(qr: CodeGenerator.generateRandomCode(),
                                name: self.name.text ?? "User",
                                id: userId)
                DataStore.shared.initUser(user, completion: { (created) in
                    if created{
                        self.proceedToApp()
                    }
                })
                
            }
        }
    }
    
    private func proceedToApp(){
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        present(vc!, animated: true, completion: nil)
    }
    
    
}
