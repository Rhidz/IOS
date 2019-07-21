//
//  ViewController.swift
//  AnimatedSets
//
//  Created by Ishrat Rhidita on 30/5/19.
//  Copyright © 2019 Ishrat Rhidita. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        for _ in 0 ..< 12 {
            if let card = game.drawModelCard(){
                 game.playingCards.append(card)
            }
           
        }
      /* gridView.frame = CGRect(x: 0.0, y: 30.0, width: 410, height: 800)
      let swipe = UISwipeGestureRecognizer(target: self, action: #selector(addCards))
      swipe.direction = .up
      gridView.addGestureRecognizer(swipe)
      self.view.addSubview(gridView)
      cards = gridView.listOfSetCards */
        print(game.playingCards)
    }
    
    lazy var game = SetGame()
    let grid = GridView()
    
   
    @objc func addCards() {
        dealCards.addCardsOnView()
}
    func touchCard(number: Int) -> Bool {
        var indexOfChosenCard: Int = number
        print(number)
      /* for index in cards.indices {
            /*if number == grid.listOfSetCard[index].identifier { */
                print(index)
                print(cards[index].identifier)
        
        }*/
        /*if game.touchCard(chosenCard: indexOfChosenCard) != nil {
            checkContentsForMatching()
        }
        else {
            for index in game.playingCards.indices {
                if index == indexOfChosenCard {
                    if game.playingCards[indexOfChosenCard].isSelected {
                        return true
                    }
                    else {
                        return false
                    }
                }
                
            }
        }*/
       return false
    }
    func checkContentsForMatching() {
        
    }
    
    @IBOutlet weak var dealCards: GridView! {
         didSet {
                let swipe = UISwipeGestureRecognizer(target: self, action: #selector(addCards))
                swipe.direction = .up
                dealCards.addGestureRecognizer(swipe)
            }
        }
        
    }
    
    


