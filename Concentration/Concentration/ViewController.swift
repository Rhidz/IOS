//
//  ViewController.swift
//  Concentration
//
//  Created by Ishrat Rhidita on 15/3/19.
//  Copyright © 2019 Ishrat Rhidita. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var choice = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        choice = Int(arc4random_uniform(UInt32(theme.count - 1)))
        print(choice)
        view.backgroundColor = backGroundColor[choice]
        emojiChoices = theme[choice]
        
        for button in cardButtons {
            button.backgroundColor = cardColor[choice]
        }
        
    }
   
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
   /* var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    } */
   
    //var theme = []
    
    @IBOutlet var cardButtons: [UIButton]!
    
    
    @IBAction func touchCard(_ sender: UIButton) {
       // flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
            score.text = "Score: \(game.score)"
        } else {
            print("choosen card was not in cardButtons")
        }
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                    button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                   
                   //print(game.score)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : cardColor[choice]
            }
        }
        
    }
    
    var emojiChoices = [String]()
    var theme = [["🐛","🐳","🦖","🐍","🦕","🐙","🐢","🐌","🐡","🐋"],
                ["🐶","🐯","🐷","🐰","🐮","🐼","🐹","🦊","🐤","🦢"],
                        ["⚽️","🏀","🏓","🏸","🎾","🏏","🎱","⛸","🥍","🥅"],
                        ["🍏","🍉","🍇","🥭","🍒","🍓","🍍","🍊","🍋","🥝"],
                        ["🥞","🍕","🌮","🍔","🍟","🧁","🍰","🍗","🥮","🍻"],
                        ["👹","👺","🤡","👻","🤖","🎃","👽","☠️","👄","👅"],
                        ["💋","🧚‍♀️","🧜🏻‍♀️","🧖‍♀️","🧞‍♂️","👰","👼🏻","👸🏻","🧟‍♂️","🧝🏻‍♀️"],
                        ["🌕","⛅️","🌈","🌙","❄️","☔️","☃️","🌜","🌚","🌞"]
                        ]
    
    var cardColor = [#colorLiteral(red: 0.1215686275, green: 0.1294117647, blue: 0.1411764706, alpha: 1),#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1),#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1),#colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1),#colorLiteral(red: 0.5638712645, green: 0.3784886599, blue: 0.07664269954, alpha: 1),#colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1),#colorLiteral(red: 0, green: 0.2228835225, blue: 0.1851072609, alpha: 1),#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)]
    
    var backGroundColor = [#colorLiteral(red: 0.3363803029, green: 0.4694271684, blue: 0.4058544636, alpha: 1),#colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1),#colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1),#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1),#colorLiteral(red: 1, green: 0.9958966374, blue: 0.82152915, alpha: 1),#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),#colorLiteral(red: 0, green: 0.772336781, blue: 0.7759585977, alpha: 1),#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)]
    
    var emoji = [Int: String]()
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count - 1)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
    
    
    @IBOutlet weak var score: UILabel!
    
    
    @IBAction func newGame(_ sender: UIButton) {
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        game.newGame()
        updateViewFromModel()
        emoji.removeAll()
        choice = Int(arc4random_uniform(UInt32(theme.count - 1)))
        emojiChoices = theme[choice]
        view.backgroundColor = backGroundColor[choice]
        score.text = "Score: 0"
        
        for button in cardButtons {
            button.backgroundColor = cardColor[choice]
        }
        
    }
    
}





