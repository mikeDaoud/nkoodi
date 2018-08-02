//
//  MoreViewController.swift
//  nkoodi
//
//  Created by Michael Attia on 8/2/18.
//  Copyright © 2018 Hajj Hackathon. All rights reserved.
//

import UIKit

class MoreViewController: UIViewController {

    @IBAction func logout(_ sender: Any) {
        DataStore.shared.logoutCurrentUser()
    }
    
    static func create() -> UIViewController{
        return UIStoryboard(name: "MoreView", bundle: nil).instantiateInitialViewController()!
    }
    
}
