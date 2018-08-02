//
//  StoreCell.swift
//  nkoodi
//
//  Created by Shimaa Magdi on 8/2/18.
//  Copyright © 2018 Hajj Hackathon. All rights reserved.
//

import UIKit

class StoreCell: UITableViewCell {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lbladdress: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.dropShadow()
    }
    
    func config(store: Store) {
        lblName.text = store.name
        lbladdress.text = store.address
    }
    
}
