//
//  Card.swift
//  Concentration
//
//  Created by Ishrat Rhidita on 16/3/19.
//  Copyright © 2019 Ishrat Rhidita. All rights reserved.
//

import Foundation

struct Card {
    
    
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    var isSeen = false
    var count = 0
    
    static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
