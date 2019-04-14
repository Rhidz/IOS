
//  Created by Ishrat Rhidita on 26/3/19.
//  Copyright © 2019 Ishrat Rhidita. All rights reserved.
//

/* Model */
import Foundation

struct SetGame {
   
    var deck = [Card]()
    var chosenCards = 0
    var playingCards = [Card]()
    /* never remove an index until deal card button is pressed */
    var indicesOfChosenCards = [Int]()
    
    init() {
        for _ in 0..<81 {
            let card = Card()
            deck += [card]
        }
        
    }
    
   mutating func drawModelCard() -> Card {
      return deck.removeFirst()
    }
    mutating func touchCard(chosenCard: Int) -> Int? {
        /* when no cards are chosen */
        var index: Int?
        if(!playingCards[chosenCard].isSelected && !playingCards[chosenCard].isMatched &&  chosenCards < 3){
            playingCards[chosenCard].isSelected = true
            chosenCards += 1
            indicesOfChosenCards.append(chosenCard)
            index = nil
            
            
        }
            /* when deselecting a card */
        else if ( playingCards[chosenCard].isSelected && !playingCards[chosenCard].isMatched && chosenCards < 3){
            playingCards[chosenCard].isSelected = false
            chosenCards -= 1
            for index in indicesOfChosenCards.indices {
                if indicesOfChosenCards[index] == chosenCard {
                    indicesOfChosenCards.remove(at: index)
                }
            }
            
            index = nil
        }
            /* when the fourth card is selected */
            /*After chosing the third card can't deselect the third card */
        else if (!playingCards[chosenCard].isSelected && !playingCards[chosenCard].isMatched && chosenCards == 3){
           index = chosenCard
        }
         
        else if ( playingCards[chosenCard].isSelected && !playingCards[chosenCard].isMatched && chosenCards == 3){
            index = nil
        }
    
        return index
    }
    
    
    mutating func matchCards(indexOf4thCard: Int) {
        var matchFound = false
        for i in indicesOfChosenCards.indices {
            if !playingCards[indicesOfChosenCards[i]].color {
                matchFound = false
            }
            else {
                matchFound = true
            }
            if !playingCards[indicesOfChosenCards[i]].shape {
                matchFound = false
            }
            else {
                matchFound = true
            }
            if !playingCards[indicesOfChosenCards[i]].content {
                matchFound = false
            }
            else {
                matchFound = true
            }
            if !playingCards[indicesOfChosenCards[i]].number {
                matchFound = false
            }
            else {
                matchFound = true
            }
        }
        
        if matchFound {
            for i in indicesOfChosenCards.indices {
                playingCards[indicesOfChosenCards[i]].isMatched = true
            }
            indicesOfChosenCards.removeAll()
            indicesOfChosenCards.append(indexOf4thCard)
            playingCards[indexOf4thCard].isSelected = true
            chosenCards = 1
            for index in playingCards.indices {
                if index != indexOf4thCard && !playingCards[index].isMatched{
                    playingCards[index].isSelected = false
                }
            }
        }
}
}

