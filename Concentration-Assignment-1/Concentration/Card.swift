//
//  Card.swift
//  Concentration
//
//  Created by Nikhil Muskur on 08/03/18.
//  Copyright © 2018 Nikhil Muskur. All rights reserved.
//

import Foundation

struct Card: Hashable
{
    var hashValue: Int {
        return identifier
    }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    var isFaceup = false
    var isMatched = false
    private var identifier: Int
    var isMisMatched = 0
    
    private static var identityValue = 0
    
    private static func identifierFactory() -> Int {
        identityValue += 1
        return identityValue
    }
    
    init() {
        self.identifier = Card.identifierFactory()
    }
}
