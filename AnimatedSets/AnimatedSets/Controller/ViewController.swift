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
            let card = game.drawModelCard()
            game.deck.append(card)
        }
        let view = SetView()
        let tapGestureRecognizer = UITapGestureRecognizer(target: view, action: #selector(SetView.didTap(sender:)))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    lazy var game = SetGame()
   
    
}

