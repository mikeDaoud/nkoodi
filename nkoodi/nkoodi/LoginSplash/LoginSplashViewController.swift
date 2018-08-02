//
//  LoginSplashViewController.swift
//  nkoodi
//
//  Created by Michael Attia on 8/1/18.
//  Copyright © 2018 Hajj Hackathon. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginSplashViewController: BaseViewController {
    
    @IBOutlet weak var container1: UIView!
    @IBOutlet weak var conatiner2: UIView!
    @IBOutlet weak var conatiner3: UIView!
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        container1.layer.cornerRadius = 22
        container1.layer.borderColor = UIColor.white.cgColor
        container1.layer.borderWidth = 1
        
        conatiner2.layer.cornerRadius = 22
        conatiner2.layer.borderColor = UIColor.white.cgColor
        conatiner2.layer.borderWidth = 1
        
        conatiner3.layer.cornerRadius = 22
        conatiner3.layer.borderColor = UIColor.white.cgColor
        conatiner3.layer.borderWidth = 1
        
        loginButton.layer.cornerRadius = 22
        registerButton.layer.cornerRadius = 22
    }
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
        DataStore.shared.beginObservingOpeartions(userId: Auth.auth().currentUser!.uid)
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        present(vc!, animated: true, completion: nil)
    }
    
    
}
