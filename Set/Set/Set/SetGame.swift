
//  Created by Ishrat Rhidita on 26/3/19.
//  Copyright © 2019 Ishrat Rhidita. All rights reserved.
//

/* Model */
import Foundation

struct SetGame {
   
    var deck = [Card]()
    var chosenCards : Int?
    var playingCards = [Card]()
    
    init() {
        for _ in 0..<81 {
            let card = Card()
            deck += [card]
        }
        
    }
    
   mutating func drawModelCard() -> Card {
      return deck.removeFirst()
    }
    mutating func touchCard(chosenCard: Int) {
        
        if(!playingCards[chosenCard].isSelected && !playingCards[chosenCard].isMatched){
            playingCards[chosenCard].isSelected = true
            
        }
        else if (playingCards[chosenCard].isSelected){
            playingCards[chosenCard].isSelected = false
        }
    }
}


