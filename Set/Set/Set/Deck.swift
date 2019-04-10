//
//  Deck.swift
//  Set
//
//  Created by Ishrat Rhidita on 9/4/19.
//  Copyright © 2019 Ishrat Rhidita. All rights reserved.
//

import Foundation

struct CardDeck {
    
    private(set) var cards = [SetCard]()
    
    init() {
        for shape in SetCard.Shape.allShape {
            for color in SetCard.Color.allColor {
                for content in SetCard.Content.allContent {
                    for number in SetCard.Number.allNumbers {
                        cards.append(SetCard(shape: shape, color: color, content: content, rank: number))
                    }
                }
            }
        }
        cards.shuffle()
    }
    
   mutating func drawCard() -> SetCard {
        
        let randomIndex = cards.count.arc4Random
        let card = cards.remove(at: randomIndex)
    
        return card
        
    }
    
}
    
    extension Int {
        var arc4Random: Int {
            switch self {
            case 1...Int.max:
                return Int(arc4random_uniform(UInt32(self)))
            case -Int.max..<0:
                return Int(arc4random_uniform(UInt32(self)))
            default:
                return 0
            }
            
        }

}
