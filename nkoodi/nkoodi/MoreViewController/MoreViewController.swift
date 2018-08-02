//
//  MoreViewController.swift
//  nkoodi
//
//  Created by Michael Attia on 8/2/18.
//  Copyright © 2018 Hajj Hackathon. All rights reserved.
//

import UIKit

class MoreViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var settings = ["Change Langauge", "Log Out"]
    
    static func create() -> UIViewController{
        return UIStoryboard(name: "MoreView", bundle: nil).instantiateInitialViewController()!
    }
}

extension MoreViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell", for: indexPath) as! SettingCell
        cell.config(title: settings[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 1:
            DataStore.shared.logoutCurrentUser()
            break
        default: break
            
        }
    }
    
}
