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
        
       for button in  cardButtons.indices {
            cardButtons[button].layer.cornerRadius = 10.0
            playingCards.append(game.drawModelCard())
            print(button)
            let card = deck.drawCard()
            let title = makeAttributes(shape: card.shape.rawValue, color: card.color.rawValue, content: card.content.rawValue, number: card.rank.rawValue.self)
            cardButtons[button].setAttributedTitle(title, for: .normal)
        }
       print(playingCards.count)
    }
    
    var playingCards = [Card]()
    var deck = CardDeck()
    var game = SetGame()
    
   
    @IBOutlet var cardButtons: [UIButton]!
    
    

    @IBAction func touchCard(_ sender: UIButton) {
        
    }
    
   /* For adding attributes to the titles of my cards */
    
    func makeAttributes(shape: String, color: String, content: String, number: Int ) -> NSAttributedString {
        var string = ""
        var c: UIColor
        var attributes : [NSAttributedString.Key : Any ] = [
            .strokeColor: UIColor.white,
            .foregroundColor: UIColor.white,
            .strokeWidth: 0.0,
            .font : UIFont.systemFont(ofSize: 35)
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
            print("nothing to add")
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
  
}


