//
//  Grid.swift
//  TestAnimatedSetCards
//
//  Created by Ishrat Rhidita on 23/6/19.
//  Copyright © 2019 Ishrat Rhidita. All rights reserved.
//

import UIKit

class Grid: UIView {

    private lazy var setCard = createSetCard()
    
    private func createSetCard() -> SetCard {
        let card = SetCard()
        addSubview(card)
        return card
    }

}
