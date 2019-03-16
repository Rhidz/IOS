//
//  Concentration.swift
//  Concentration
//
//  Created by Ishrat Rhidita on 16/3/19.
//  Copyright © 2019 Ishrat Rhidita. All rights reserved.
//

import Foundation
class Concentration {
    
    var cards = [Card]()
    var indexOfOneAndOnlyFaceUpCard: Int?
    var score = 0
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                    cards[index].isFaceUp = true
                    indexOfOneAndOnlyFaceUpCard = nil
                } /* implemention of the score logic */
                else{
                    cards[index].isFaceUp = true
                    
                    if cards[matchIndex].isSeen && cards[matchIndex].count > 1{
                        score -= 1
                    }
                    if cards[index].isSeen {
                        score -= 1
                        
                    }
                    else{
                        cards[index].isSeen = true
                    }
                    indexOfOneAndOnlyFaceUpCard = nil
                }
               
            } // when the cards don't match and you flip the third card
              else {
                // either no card or two cards face up
                for flipdownIndex in cards.indices {
                    cards[flipdownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
                cards[index].isSeen = true
                cards[index].count += 1
            }
            
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        
        //    TODO: Shuffle the cards
        cards.shuffle()
    }
    
    func newGame(){
        score = 0
        for i in cards.indices{
            cards[i].isSeen = false
            cards[i].isFaceUp = false
            cards[i].count = 0
            cards[i].isMatched = false
        }
    }
}
