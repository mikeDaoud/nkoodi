//
//  Category.swift
//  nkoodi
//
//  Created by Shimaa Magdi on 8/2/18.
//  Copyright © 2018 Hajj Hackathon. All rights reserved.
//

import Foundation
import UIKit

struct Category {
    var name: String
    var stores: [Store]
    
    init(name: String, stores: [Store]) {
        self.name = name
        self.stores = stores
    }
}

struct Store {
    var name: String
    var address: String
    
    init(name: String, address: String) {
        self.name = name
        self.address = address
    }
}
