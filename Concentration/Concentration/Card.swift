//
//  Card.swift
//  Concentration
//
//  Created by Nikhil Muskur on 08/03/18.
//  Copyright © 2018 Nikhil Muskur. All rights reserved.
//

import Foundation

struct Card{
    var isFaceup = false
    var isMatched = false
    var identifier: Int
    var isMisMatched = 0
    
    static var identityValue = 0
    
    static func identifierFactory() -> Int {
        identityValue += 1
        return identityValue
    }
    
    init() {
        self.identifier = Card.identifierFactory()
    }
}
