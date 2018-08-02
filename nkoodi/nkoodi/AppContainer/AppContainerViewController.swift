//
//  AppContainerViewController.swift
//  nkoodi
//
//  Created by Michael Attia on 8/2/18.
//  Copyright © 2018 Hajj Hackathon. All rights reserved.
//

import UIKit

class AppContainerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(operationDetected(_:)), name: NSNotification.Name(rawValue: "new_operation"), object: nil)
        // Do any additional setup after loading the view.
        
        let vc = UIStoryboard(name: "LoginSplashView", bundle: nil).instantiateInitialViewController()!
        self.view.addSubview(vc.view)
        self.addChildViewController(vc)
        vc.didMove(toParentViewController: self)
    }
    
    @objc func operationDetected(_ notification: NSNotification){
        // Get operation ID
        // Get vendro and amount data correctly
        if let userInfo = notification.userInfo,
            let vendor = userInfo["vendor"] as? String,
            let amount = userInfo["amount"] as? Double,
            let opID = userInfo["opId"] as? String{
            let alert = UIAlertController(title: "Payment Requested", message: "\(vendor) requested the payment of \(amount)", preferredStyle: .alert)
            let approveAction = UIAlertAction(title: "Approve", style: .default) { (_) in
                DataStore.shared.change(operation: opID, to: "approved")
                PopupManager.dismissPopup()
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .destructive) { (_) in
                DataStore.shared.change(operation: opID, to: "cancelled")
                PopupManager.dismissPopup()
            }
            alert.addAction(approveAction)
            alert.addAction(cancelAction)
//            self.present(alert, animated: true, completion: nil)
            PopupManager.showPopup(vc: alert)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}
