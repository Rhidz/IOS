//
//  ViewController.swift
//  Set
//
//  Created by Ishrat Rhidita on 22/3/19.
//  Copyright © 2019 Ishrat Rhidita. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
       for button in cardButtons.indices {
            cardButtons[button].layer.cornerRadius = 12.0
            dealCards.layer.cornerRadius = 16.0
            dealCards.layer.shadowColor = UIColor.cyan.cgColor
            dealCards.layer.shadowRadius = 4.0
            dealCards.layer.shadowOpacity = 0.5
            dealCards.layer.shadowOffset = CGSize(width: 0, height: 0)
            game.playingCards.append(game.drawModelCard())
            testCards.append(game.playingCards[button])
            let card = deck.drawCard()
           cardTitles[game.playingCards[button]] = card
            let title = makeAttributes(shape: card.shape.rawValue, color: card.color.rawValue, content: card.content.rawValue, number: card.rank.rawValue.self)
            cardButtons[button].setAttributedTitle(title, for: .normal)
        }
        
    }
    
    var cardTitles = [Card:SetCard]()
    var deck = CardDeck()
    var game = SetGame()
    /* this should be same as array for playing cards */
    var testCards = [Card]()
    
    @IBOutlet weak var dealCards: UIButton! 
    
    @IBOutlet var cardButtons: [UIButton]!
    
    
    @IBOutlet weak var gameScore: UILabel!
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            if let index = game.touchCard(chosenCard: cardNumber) {
            checkContentsForMatching(forIndex: index)
            }
            else {
            updateView()
            }
        }
   }
    
   /* For adding attributes to the titles of my cards */
    
    func makeAttributes(shape: String, color: String, content: String, number: Int ) -> NSAttributedString {
        var string = ""
        var c: UIColor
        var attributes : [NSAttributedString.Key : Any ] = [
            .strokeColor: UIColor.white,
            .foregroundColor: UIColor.white,
            .strokeWidth: 0.0,
            .font : UIFont.systemFont(ofSize: 39)
           ]
        
        switch shape {
        case "triangle":
            string = "▲"
        case "sqaure":
            string = "■"
        case "circle":
            string = "●"
        default:
            string = ""
        }
        
        switch color {
        case "red":
            c = UIColor.red
        case "green":
            c = UIColor.green
        case "purple":
            c = UIColor.purple
        default:
            c = UIColor.white
        }
        
        switch content {
        case "filled":
           attributes.updateValue(c, forKey: .foregroundColor)
           attributes.updateValue(c, forKey: .strokeColor)
        case "outlined":
            attributes.updateValue(UIColor.white, forKey: .foregroundColor)
            attributes.updateValue(c, forKey: .strokeColor)
            attributes.updateValue(-7.0, forKey: .strokeWidth)
        case "strided":
            attributes.updateValue(c.withAlphaComponent(0.35), forKey: .foregroundColor)
            attributes.updateValue(c, forKey: .strokeColor)
            attributes.updateValue(-7.0, forKey: .strokeWidth)
        default:
            print("Never coming here")
        }
        
        switch number {
        case 1:
            print("")
        case 2:
            string = string + string
        case 3:
            string = string + string + string
        default:
            print("whatever")
        }
        
        let title = NSAttributedString(string: string, attributes: attributes)
        return title
        }
    
 func updateView(){
        
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.playingCards[index]
            if card.isSelected && !card.isMatched{
                button.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
                button.layer.cornerRadius = 17.0
                button.layer.borderWidth = 2
                button.layer.borderColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
               
            }
            else if !card.isMatched{
                button.backgroundColor = #colorLiteral(red: 0.6064082384, green: 0.729287684, blue: 0.7931819558, alpha: 1)
                button.layer.cornerRadius = 12.0
                button.layer.borderWidth = 0
                button.layer.borderColor = nil
            }
            else {
                button.backgroundColor = #colorLiteral(red: 0.0104322182, green: 0.06354571134, blue: 0.1578483284, alpha: 1)
                button.layer.borderWidth = 0
                button.layer.borderColor = nil
                button.layer.cornerRadius = 0.0
                button.setTitle(nil, for: .normal)
                button.setAttributedTitle(nil, for: .normal)
            }
        }
        
    }
    
    func checkContentsForMatching(forIndex: Int) {
       
        var cards = [SetCard]()
        /*print(game.indicesOfChosenCards)
        print(game.indicesOfChosenCards.indices) */
        
        for index in game.indicesOfChosenCards.indices {
          cards.append(cardTitles[testCards[game.indicesOfChosenCards[index]]]!)
            print("\(cards[index].color) + \(cards[index].content) + \(cards[index].rank)")
            
            
        }
        
        /* for color */
        if (cards[0].color == cards[1].color) && (cards[1].color == cards[2].color) && (cards[0].color == cards[2].color) {
            game.playingCards[game.indicesOfChosenCards[0]].color = true
            game.playingCards[game.indicesOfChosenCards[1]].color = true
            game.playingCards[game.indicesOfChosenCards[2]].color = true
            //print("I am here")
        }
        else if cards[0].color == cards[1].color {
            game.playingCards[game.indicesOfChosenCards[0]].color = true
            game.playingCards[game.indicesOfChosenCards[1]].color = true
            
        }
        else if cards[1].color == cards[2].color {
            game.playingCards[game.indicesOfChosenCards[1]].color = true
            game.playingCards[game.indicesOfChosenCards[2]].color = true

        }
        else if cards[0].color == cards[2].color {
            game.playingCards[game.indicesOfChosenCards[0]].color = true
            game.playingCards[game.indicesOfChosenCards[2]].color = true
        }
        /* for shape */
        if (cards[0].shape == cards[1].shape) && (cards[1].shape == cards[2].shape) && (cards[0].shape == cards[2].shape) {
            game.playingCards[game.indicesOfChosenCards[0]].shape = true
            game.playingCards[game.indicesOfChosenCards[1]].shape = true
            game.playingCards[game.indicesOfChosenCards[2]].shape = true
        }
        else if cards[0].shape == cards[1].shape {
            game.playingCards[game.indicesOfChosenCards[0]].shape = true
            game.playingCards[game.indicesOfChosenCards[1]].shape = true
        }
        else if cards[1].shape == cards[2].shape {
            game.playingCards[game.indicesOfChosenCards[1]].shape = true
            game.playingCards[game.indicesOfChosenCards[2]].shape = true
        }
        else if cards[0].shape == cards[2].shape {
            game.playingCards[game.indicesOfChosenCards[0]].shape = true
            game.playingCards[game.indicesOfChosenCards[2]].shape = true
        }
        /* for content */
  
        if (cards[0].content == cards[1].content) && (cards[1].content == cards[2].content) && (cards[0].content == cards[2].content) {
            game.playingCards[game.indicesOfChosenCards[0]].content = true
            game.playingCards[game.indicesOfChosenCards[1]].content = true
            game.playingCards[game.indicesOfChosenCards[2]].content = true
        }
        else if cards[0].content == cards[1].content{
            game.playingCards[game.indicesOfChosenCards[0]].content = true
            game.playingCards[game.indicesOfChosenCards[1]].content = true
        }
        else if cards[1].content == cards[2].content {
            game.playingCards[game.indicesOfChosenCards[1]].content = true
            game.playingCards[game.indicesOfChosenCards[2]].content = true
        }
        else if cards[0].content == cards[2].content {
            game.playingCards[game.indicesOfChosenCards[0]].content = true
            game.playingCards[game.indicesOfChosenCards[2]].content = true
        }
      /* for number */
        if (cards[0].rank == cards[1].rank) && (cards[1].rank == cards[2].rank) && (cards[0].rank == cards[2].rank) {
            game.playingCards[game.indicesOfChosenCards[0]].number = true
            game.playingCards[game.indicesOfChosenCards[1]].number = true
            game.playingCards[game.indicesOfChosenCards[2]].number = true
        }
        else if cards[0].rank == cards[1].rank {
            game.playingCards[game.indicesOfChosenCards[0]].number = true
            game.playingCards[game.indicesOfChosenCards[1]].number = true
        }
        else if cards[1].rank == cards[2].rank {
            game.playingCards[game.indicesOfChosenCards[1]].number = true
            game.playingCards[game.indicesOfChosenCards[2]].number = true
        }
        else if cards[0].rank == cards[2].rank {
            game.playingCards[game.indicesOfChosenCards[0]].number = true
            game.playingCards[game.indicesOfChosenCards[2]].number = true
        } 
        game.matchCards(indexOf4thCard: forIndex)
        updateView()
    }
  
    @IBAction func deal(_ sender: Any) {
        var places = game.dealCards()
        print(places)
        for index in places.indices {
            testCards[places[index]] = game.playingCards[places[index]]
            print(testCards[places[index]])
            let card = deck.drawCard()
            cardTitles[testCards[places[index]]] = card
           let title = makeAttributes(shape: card.shape.rawValue, color: card.color.rawValue, content: card.content.rawValue, number: card.rank.rawValue.self)
            cardButtons[places[index]].setAttributedTitle(title, for: .normal)
            cardButtons[places[index]].backgroundColor = #colorLiteral(red: 0.6064082384, green: 0.729287684, blue: 0.7931819558, alpha: 1)
            cardButtons[places[index]].layer.cornerRadius = 12.0
         
        }
        }
    }
    




