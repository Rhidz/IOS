//
//  SetCard.swift
//  GraphicalSets
//
//  Created by Ishrat Rhidita on 20/7/19.
//  Copyright © 2019 Ishrat Rhidita. All rights reserved.
//

import Foundation

struct SetCard : Hashable {
    
    var shape : Shape
    var color: Color
    var content: Content
    var rank: Number
    
    enum Shape: String {
        case oval
        case squiggle
        case diamonds
        case emoji
        static var allShape = [Shape.oval, .squiggle, .diamonds]
    }
    
    enum Color: String {
        case red
        case purple
        case green
        case blue
        static var allColor = [Color.red, .purple, .green]
    }
    
    enum Content: String {
        case filled
        case outlined
        case strided
        case different
        static var allContent = [Content.filled, .outlined, .strided]
    }
    
    enum Number: Int {
        case one = 1
        case two = 2
        case three = 3
        
        static var allNumbers = [Number.one, .two,.three]
    }
    
}

