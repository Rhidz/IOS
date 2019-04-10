//
//  SetCard.swift
//  Set
//
//  Created by Ishrat Rhidita on 9/4/19.
//  Copyright © 2019 Ishrat Rhidita. All rights reserved.
//

import Foundation

struct SetCard {
    
    var shape : Shape
    var color: Color
    var content: Content
    var rank: Number
    
    enum Shape: String {
        case triangle
        case sqaure
        case circle
        
        static var allShape = [Shape.triangle, .sqaure, .circle]
    }
    
    enum Color: String {
        case red
        case purple
        case green
        
        static var allColor = [Color.red, .purple, .green]
    }
    
    enum Content: String {
        case filled
        case outlined
        case strided
        
        static var allContent = [Content.filled, .outlined, .strided]
    }
    
    enum Number: Int {
        case one = 1
        case two = 2
        case three = 3
        
        static var allNumbers = [Number.one, .two,.three]
    }
    
}
