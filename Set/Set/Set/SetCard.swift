//
//  SetCard.swift
//  Set
//
//  Created by Ishrat Rhidita on 9/4/19.
//  Copyright © 2019 Ishrat Rhidita. All rights reserved.
//
/* UI card is called a Set Card */
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
        case emoji
        static var allShape = [Shape.triangle, .sqaure, .circle]
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
        case four = 4
        static var allNumbers = [Number.one, .two,.three]
    }
    
}
