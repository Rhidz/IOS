//
//  ViewController.swift
//  PlayingCards
//
//  Created by Ishrat Rhidita on 27/4/19.
//  Copyright © 2019 Ishrat Rhidita. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var deck = PlayingCardDeck()

    override func viewDidLoad() {
        super.viewDidLoad()
        for _ in 1...10 {
            if let card = deck.draw(){
                print("\(card)")
            }
        }
        // Do any additional setup after loading the view.
    }


}

