//
//  GridView.swift
//  GraphicalSets
//
//  Created by Ishrat Rhidita on 20/7/19.
//  Copyright © 2019 Ishrat Rhidita. All rights reserved.
//

import UIKit

class GridView: UIView {
    
   var listOfSetCards = [SetView]()

   lazy var grid = Grid(layout: Grid.Layout.fixedCellSize(CGSize(width: 128.0, height: 110.0)), frame: CGRect(origin: CGPoint(x: bounds.minX, y: bounds.minY), size: CGSize(width: bounds.width, height: bounds.height)))
    
    var cardsOnScreen = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        for index in listOfSetCards.indices {
            let card = listOfSetCards[index]
            if let rect = grid[index] {
                card.frame = rect.insetBy(dx: 1.5, dy: 1.5)
                card.frame.origin = rect.origin
            }
        }
    }
    override func draw(_ rect: CGRect) {
        let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: 15.0)
        let color = #colorLiteral(red: 0.8445288539, green: 0.1451442242, blue: 0.3822338581, alpha: 0.9444295805)
        
        color.setFill()
        roundedRect.fill()
    }
    func updateView(atIndex: Int, isSelected: Bool, isMatched: Bool) {
        listOfSetCards[atIndex].isSelected = isSelected
        listOfSetCards[atIndex].isMatched = isMatched
        
    }

}
