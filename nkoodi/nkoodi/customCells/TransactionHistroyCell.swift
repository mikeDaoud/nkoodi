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
    
    @IBOutlet weak var transactionDataLabel: UILabel!
    @IBOutlet weak var transactionAmountLabel: UILabel!
    @IBOutlet weak var statusColorView: UIView!
    
    func configure(transaction: Transaction) {
        let date = Date.init(timeIntervalSince1970: TimeInterval.init(transaction.date))
        let dateStr = "\(date.description(with: Locale.init(identifier: "en_US_POSIX")))"
        transactionDataLabel.text = "\(dateStr)\n\(transaction.vendor)\n\(transaction.operation.rawValue)"
        transactionAmountLabel.text = "\(transaction.amountChanged)"
        statusColorView.backgroundColor = transaction.operation.colorValue
    }
}
