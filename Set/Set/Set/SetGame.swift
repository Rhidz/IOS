
//  Created by Ishrat Rhidita on 26/3/19.
//  Copyright © 2019 Ishrat Rhidita. All rights reserved.
//

/* Model */
import Foundation

struct SetGame {
   
    var deck = [Card]()
    /* this array required for chosing the cards and matching them. Maximum length of this
     array should be three */
    //var chosenCards = [Card]()
   
    init() {
        for _ in 0..<81 {
            let card = Card()
            deck += [card]
        }
        
    }
    
    
   mutating func drawModelCard() -> Card {
        let randomIndex = deck.count.arc4Random
        return deck.remove(at: randomIndex)
    }
}


