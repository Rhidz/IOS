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
        for _ in 1...12 {
            if let card = game.drawModelCard() {
            game.playingCards.append(card)
        }
        
    }
    }
    lazy var game = SetGame()
   
    
}

