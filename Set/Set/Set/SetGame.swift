
//  Created by Ishrat Rhidita on 26/3/19.
//  Copyright © 2019 Ishrat Rhidita. All rights reserved.
//

/* Model */
import Foundation
struct SetGame {
    var deck = [Card]()
    var chosenCards = 0
    var playingCards = [Card]()
    var indicesOfChosenCards = [Int]()
    var indicesofMatchedCards = [Int]()
    init() {
        for _ in 0..<81 {
            let card = Card()
            deck += [card]
        }
    }
   mutating func drawModelCard() -> Card {
    var c: Card?
    if deck.isEmpty {
        c = nil
    }else{
        c = deck.removeFirst()
    }
    return c!
    }
 mutating func touchCard(chosenCard: Int) -> Int? {
        var index: Int?
        if(!playingCards[chosenCard].isSelected && !playingCards[chosenCard].isMatched) {
           if chosenCards < 3 {
            playingCards[chosenCard].isSelected = true
            print(playingCards[chosenCard].shape)
            chosenCards += 1
            indicesOfChosenCards.append(chosenCard)
            index = nil
            }
            else if chosenCards == 3 {
               index = chosenCard
            }
            
        }else if  playingCards[chosenCard].isSelected && !playingCards[chosenCard].isMatched && chosenCards < 3 {
            for i in indicesOfChosenCards.indices {
                if indicesOfChosenCards[i] == chosenCard {
                    indicesOfChosenCards.remove(at: i)
                    break
                }
            }
            playingCards[chosenCard].isSelected = false
            chosenCards -= 1
            index = nil
        }
           else if (playingCards[chosenCard].isSelected && !playingCards[chosenCard].isMatched && chosenCards == 3){
            index = nil
        }
     return index
    }
    mutating func matchCards(indexOf4thCard: Int) {
        var matchCount = [0,0,0,0]
        var matchFound = false
        for i in indicesOfChosenCards.indices {
            if playingCards[indicesOfChosenCards[i]].color {
                matchCount[0] += 1
            }
            
            if playingCards[indicesOfChosenCards[i]].shape {
                matchCount[1] += 1
            }
            
            if playingCards[indicesOfChosenCards[i]].content {
                matchCount[2] += 1
             }
            
            if playingCards[indicesOfChosenCards[i]].number {
                matchCount[3] += 1
            }
           
        }
         print(matchCount)
      for i in matchCount.indices {
            if i == 0 {
                if (matchCount[i] == 3) && (matchCount[i+1] == 0 || matchCount[i+1] == 3) && (matchCount[i+2] == 0 || matchCount[i+2] == 3) &&  (matchCount[i+3] == 0 || matchCount[i+3] == 3) {
                    matchFound = true
               } }
            else if i == 1 {
                if (matchCount[i-1] == 0 || matchCount[i-1] == 3 ) && (matchCount[i] == 3) && (matchCount[i+1] == 0 || matchCount[i+1] == 3) && (matchCount[i+2]  == 0 || matchCount[i+2] == 3) {
                    matchFound = true
                } }
            else if i == 2 {
                if (matchCount[i-2] == 0 || matchCount[i-2] == 3) && (matchCount[i-1] == 0 || matchCount[i-1] == 3 ) && (matchCount[i] == 3) && (matchCount[i+1] == 0 || matchCount[i+1] == 3) {
                    matchFound = true
            } }
            else  {
                if (matchCount[i-3] == 0 || matchCount[i-3] == 3)  && (matchCount[i-2] == 0 || matchCount[i-2] == 3) && (matchCount[i-1] == 0 || matchCount[i-1] == 3) && (matchCount[i] == 3) {
                    matchFound = true
               } } }
        if matchFound {
            for i in indicesOfChosenCards.indices {
                playingCards[indicesOfChosenCards[i]].isMatched = true
            }
           for i in indicesOfChosenCards.indices {
               indicesofMatchedCards.append(indicesOfChosenCards[i])
            }
            print(indicesofMatchedCards)
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
        else {
            for i in indicesOfChosenCards.indices {
                playingCards[indicesOfChosenCards[i]].color = false
                playingCards[indicesOfChosenCards[i]].content = false
                playingCards[indicesOfChosenCards[i]].number = false
                playingCards[indicesOfChosenCards[i]].shape = false
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
    mutating func dealCards()-> [Int] {
        var lisOfIndexes = [Int]()
        if indicesofMatchedCards.count > 0 {
              for i in 0...2 {
                playingCards[indicesofMatchedCards[i]] = drawModelCard()
                lisOfIndexes.append(indicesofMatchedCards[i])
                
            }
            if(indicesofMatchedCards.count == 3) {
                indicesofMatchedCards.removeAll()
            }
            else {
                indicesofMatchedCards.removeFirst(3)
            }
        }
         return lisOfIndexes
    }}

