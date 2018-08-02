//
//  SettingCell.swift
//  nkoodi
//
//  Created by Shimaa Magdi on 8/2/18.
//  Copyright © 2018 Hajj Hackathon. All rights reserved.
//

import UIKit

class SettingCell: UITableViewCell {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.dropShadow()
    }
    
    func config(title: String) {
        lblName.text = title
    }
    
}
