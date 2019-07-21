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
    var cardTitles = [Card:SetCard]() /* A dictionary for where the key is the Card and the value for that is a SetCard */
    var deck = CardDeck()
    var game = SetGame()
    /* this should be same as the array for playing cards */
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
            string = "No more Cards Left"
        }
        
        switch color {
        case "red":
            c = UIColor.red
        case "green":
            c = UIColor.green
        case "purple":
            c = UIColor.purple
        default:
            c = UIColor.blue
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
            attributes.updateValue(c, forKey: .foregroundColor)
            attributes.updateValue(c, forKey: .strokeColor)
        }
        
        switch number {
        case 1:
            print("")
        case 2:
            string = string + string
        case 3:
            string = string + string + string
        default:
            string = "No more card dumbass!!"
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
    
    func colorSetting(param0: SetCard.Color, param1: SetCard.Color, param2: SetCard.Color) {
        let allColorsMatch = (param0 == param1) && (param1 == param2) && (param0 == param2)
        
        let zeroAndOneMatch = param0 == param1
        let oneAndTwoMatch = param1 == param2
        let zeroAndTwoMatch = param0 == param2
        
        game.playingCards[game.indicesOfChosenCards[0]].color = allColorsMatch || zeroAndOneMatch || zeroAndTwoMatch
        game.playingCards[game.indicesOfChosenCards[1]].color = allColorsMatch || zeroAndOneMatch || oneAndTwoMatch
        game.playingCards[game.indicesOfChosenCards[2]].color = allColorsMatch || zeroAndTwoMatch || oneAndTwoMatch
    }
    func rankSetting(param0: SetCard.Number, param1: SetCard.Number, param2: SetCard.Number) {
        let allColorsMatch = (param0 == param1) && (param1 == param2) && (param0 == param2)
        
        let zeroAndOneMatch = param0 == param1
        let oneAndTwoMatch = param1 == param2
        let zeroAndTwoMatch = param0 == param2
        
        game.playingCards[game.indicesOfChosenCards[0]].number = allColorsMatch || zeroAndOneMatch || zeroAndTwoMatch
        game.playingCards[game.indicesOfChosenCards[1]].number = allColorsMatch || zeroAndOneMatch || oneAndTwoMatch
        game.playingCards[game.indicesOfChosenCards[2]].number = allColorsMatch || zeroAndTwoMatch || oneAndTwoMatch
    }
    func contentSetting(param0: SetCard.Content, param1: SetCard.Content, param2: SetCard.Content) {
        let allColorsMatch = (param0 == param1) && (param1 == param2) && (param0 == param2)
        
        let zeroAndOneMatch = param0 == param1
        let oneAndTwoMatch = param1 == param2
        let zeroAndTwoMatch = param0 == param2
        
        game.playingCards[game.indicesOfChosenCards[0]].content = allColorsMatch || zeroAndOneMatch || zeroAndTwoMatch
        game.playingCards[game.indicesOfChosenCards[1]].content = allColorsMatch || zeroAndOneMatch || oneAndTwoMatch
        game.playingCards[game.indicesOfChosenCards[2]].content = allColorsMatch || zeroAndTwoMatch || oneAndTwoMatch
    }
    func shapeSetting(param0: SetCard.Shape, param1: SetCard.Shape, param2: SetCard.Shape) {
        let allColorsMatch = (param0 == param1) && (param1 == param2) && (param0 == param2)
        
        let zeroAndOneMatch = param0 == param1
        let oneAndTwoMatch = param1 == param2
        let zeroAndTwoMatch = param0 == param2
        
        game.playingCards[game.indicesOfChosenCards[0]].shape = allColorsMatch || zeroAndOneMatch || zeroAndTwoMatch
        game.playingCards[game.indicesOfChosenCards[1]].shape = allColorsMatch || zeroAndOneMatch || oneAndTwoMatch
        game.playingCards[game.indicesOfChosenCards[2]].shape = allColorsMatch || zeroAndTwoMatch || oneAndTwoMatch
    }
    
    func checkContentsForMatching(forIndex: Int) {
        var cards = [SetCard]()
        for index in game.indicesOfChosenCards.indices {
            cards.append(cardTitles[testCards[game.indicesOfChosenCards[index]]]!)
        }
        colorSetting(param0: cards[0].color,param1: cards[1].color, param2: cards[2].color)
        rankSetting(param0: cards[0].rank, param1: cards[1].rank, param2: cards[2].rank)
        contentSetting(param0: cards[0].content, param1: cards[1].content, param2: cards[2].content)
        shapeSetting(param0: cards[0].shape, param1: cards[1].shape, param2: cards[2].shape)
        game.matchCards(indexOf4thCard: forIndex)
        updateView()
    }
    @IBAction func deal(_ sender: Any) {
        var places = game.dealCards()
        //print(places)
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
    




