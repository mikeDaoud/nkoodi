//
//  PopupManager.swift
//  nkoodi
//
//  Created by Michael Attia on 8/2/18.
//  Copyright © 2018 Hajj Hackathon. All rights reserved.
//

import UIKit

class PopupManager{
    static var shared = PopupManager()
    
    static var window: UIWindow?
    
    static func showPopup(vc: UIViewController){
        window = UIWindow()
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }
    
    static func dismissPopup(){
        window = nil
    }
    
}
