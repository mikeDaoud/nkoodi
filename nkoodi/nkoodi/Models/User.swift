//
//  User.swift
//  nkoodi
//
//  Created by Michael Attia on 8/2/18.
//  Copyright © 2018 Hajj Hackathon. All rights reserved.
//

import Foundation

struct User {
    var qr: String
    var name: String
    var id: String
    
    var fireBaseDict: NSDictionary{
        return ["name" : self.name,
                "qr": self.qr,
                "id" : self.id,
                "current_balance" : 100.0]
    }
}

extension User{
    init?(dict: NSDictionary, id: String){
        guard let name = dict["name"] as? String,
            let qr = dict["qr"] as? String else {return nil}
        self.id = id
        self.name = name
        self.qr = qr
    }
}
