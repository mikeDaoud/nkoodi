//
//  BaseViewController.swift
//  nkoodi
//
//  Created by Shimaa Magdi on 8/2/18.
//  Copyright © 2018 Hajj Hackathon. All rights reserved.
//

import UIKit
import Pastel

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let pastelView = PastelView(frame: view.bounds)
        
        // Custom Direction
        pastelView.startPastelPoint = .bottomLeft
        pastelView.endPastelPoint = .topRight
        
        // Custom Duration
        pastelView.animationDuration = 3.0
        
        // Custom Color
        pastelView.setColors([UIColor(hexString: "#2af598"), UIColor(hexString: "#009efd")])
        
        pastelView.startAnimation()
        view.insertSubview(pastelView, at: 0)
    }
}
