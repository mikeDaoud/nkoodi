//
//  TransactionHistroyCell.swift
//  nkoodi
//
//  Created by marko nazmy on 8/2/18.
//  Copyright © 2018 Hajj Hackathon. All rights reserved.
//

import Foundation
import UIKit

class TransactionHistroyCell: UITableViewCell {
    
    @IBOutlet weak var opertationLabel: UILabel!
    @IBOutlet weak var vendorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var transactionAmountLabel: UILabel!
    @IBOutlet weak var statusColorView: UIView!
    @IBOutlet weak var container: UIView!
    
    func configure(transaction: Transaction) {
        container.dropShadow()
        let date = Date.init(timeIntervalSince1970: TimeInterval.init(transaction.date))
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        let dateStr = "\(formatter.string(from: date))"
        dateLabel.text = "\(dateStr)"
        vendorLabel.text = "\(transaction.vendor)"
        opertationLabel.text = "\(transaction.operation.rawValue.capitalized)"
        transactionAmountLabel.text = "\(transaction.amountChanged)"
        if transaction.amountChanged < 0 {
            transactionAmountLabel.textColor = UIColor.red
        }else {
            transactionAmountLabel.textColor = UIColor.green
        }
        statusColorView.backgroundColor = transaction.operation.colorValue
        container.layer.masksToBounds = true
        container.layer.cornerRadius = 10
    }
}
