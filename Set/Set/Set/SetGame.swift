//
//  File.swift
//  Set
//
//  Created by Ishrat Rhidita on 26/3/19.
//  Copyright © 2019 Ishrat Rhidita. All rights reserved.
//

import Foundation

struct Set {
    
    /* Need to make a deck of 81 cards each time the game starts.
       Chose a card randomly from the deck
       Set some attribute from the UI
       Use that attribute to match cards
     */
    
    var deck = [Card]()
    /* this array required for chosing the cards and matching them. Maximum length of this
     array should be three */
    var chosenCards = [Card]()
    
    
    
    init() {
        for _ in 0..<81 {
            let card = Card()
            deck += [card]
        }
    }
    
    func drawCard() -> Card {
        return deck[Int(arc4random_uniform(UInt32(deck.count - 1)))]
    }
}
