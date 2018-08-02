//
//  CodeGenerator.swift
//  nkoodi
//
//  Created by Michael Attia on 8/2/18.
//  Copyright © 2018 Hajj Hackathon. All rights reserved.
//

import Foundation

class CodeGenerator{
    static func generateRandomCode() -> String{
        return String(UUID().uuidString.prefix(6))
    }
}
