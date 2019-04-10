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
        
        
        //print(card.color)
        
       for button in cardButtons.indices{
        
            cardButtons[button].layer.cornerRadius = 10.0
            let card = deck.drawCard()
        let title = makeAttributes(shape: card.shape.rawValue, color: card.color.rawValue, content: card.content.rawValue, number: card.rank.rawValue.self)
            cardButtons[button].setAttributedTitle(title, for: .normal)
        }
        
    }
    
    var deck = CardDeck()
    
   
    @IBOutlet var cardButtons: [UIButton]!

    @IBAction func touchCard(_ sender: UIButton) {
    }
    
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
            print("Neve coming here")
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
    
    /* Make an array of attributed strings, while loading select 24 or 12 of the 81 combinations.
      Each time deal three cards button is pressed select three attributed strings from the array.
      Make a dictionary of card and string to set title for that card using the attributed string */
    
    
    
    /* let at: [NSAttributedString.Key : Any] = [
     .strokeColor : UIColor.blue,
     .foregroundColor : UIColor.white,
     
     
     ]
     
     let s = NSAttributedString(string: "●", attributes: at)
     let attribute: [NSAttributedString.Key : Any] = [
     .strokeColor : UIColor.purple,
     .foregroundColor : UIColor.purple.withAlphaComponent(0.3),
     .strokeWidth : -7.0,
     .font : UIFont.systemFont(ofSize: 35)
     
     
     
     ] */
    
    /* let a = NSAttributedString(string: "▲", attributes: attribute)
     
     let button = cardButtons[1]
     button.setAttributedTitle(s, for: .normal)
     
     let secondButton = cardButtons[0]
     secondButton.setAttributedTitle(a, for: .normal)
     
     
     */
    // Do any additional setup after loading the view, typically from a nib.
}
extension UIColor {
    
}

