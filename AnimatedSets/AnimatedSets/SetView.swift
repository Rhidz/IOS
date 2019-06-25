//
//  SetView.swift
//  AnimatedSets
//
//  Created by Ishrat Rhidita on 30/5/19.
//  Copyright © 2019 Ishrat Rhidita. All rights reserved.
//

import UIKit

class SetView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: 8.0)
        UIColor.white.setFill()
        roundedRect.fill()
        backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
    }
 

}
