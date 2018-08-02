//
//  TransactionsHistory.swift
//  nkoodi
//
//  Created by Michael Attia on 8/2/18.
//  Copyright © 2018 Hajj Hackathon. All rights reserved.
//

import Foundation
import UIKit

struct TransactionsHistory {
    var currentBalance: Double
    var transactions: [Transaction]
}

struct Transaction {
    var date: Double
    var amountChanged: Double
    var operation: TransactionOperation
    var vendor: String
}

enum TransactionOperation: String{
    case transfer = "transfer"
    case payment = "payment"
    case cancelled = "cancelled"
    case recieved = "recieved"
    case none = ""
    
    var colorValue: UIColor {
        switch self {
        case .transfer:
            return UIColor.yellow
        case .payment:
            return UIColor.orange
        case .cancelled:
            return UIColor.red
        case .recieved:
            return UIColor.green
        default:
            return UIColor.white
        }
    }
}
