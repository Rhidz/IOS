//
//  SetView.swift
//  AnimatedSets
//
//  Created by Ishrat Rhidita on 30/5/19.
//  Copyright © 2019 Ishrat Rhidita. All rights reserved.
//

import UIKit

class SetView: UIView {
    var isSelected = false
    let offset: CGFloat = 3.25
    var isLineAtStartingPoint = false
    var isLineAtEndingPoint = false
    
  
/* I never want to change the value of this variable */
    static var identifier: Int = 0
    private var spacing: CGFloat = 0.0
    var combinationOnCard: (shape: SetCard.Shape, color: SetCard.Color, content: SetCard.Content, rank: SetCard.Number) = (SetCard.Shape.emoji, SetCard.Color.blue, SetCard.Content.different, SetCard.Number.four) {
        didSet {
            setNeedsDisplay()
        }
    }
    lazy var widthForEachShape = calculateWidth(for: bounds.insetBy(dx: 0.0, dy: (bounds.height / 4)))
    override init(frame: CGRect) {
        super.init(frame: frame)
        incrementIdentifier()
   }
    private func incrementIdentifier() {
        SetView.identifier += 1
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
  
    override func draw(_ rect: CGRect) {
        let rect = UIBezierPath(rect: bounds)
        fillBoundingRect(inRect: rect, color: UIColor.white)
        var path = UIBezierPath()
        var color = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        switch combinationOnCard.color {
        case SetCard.Color.green:
            color = #colorLiteral(red: 0, green: 0.6342709661, blue: 0.3612936139, alpha: 1)
            color.setStroke()
        case SetCard.Color.purple:
            color = #colorLiteral(red: 0.3970748484, green: 0.4056298137, blue: 0.919711411, alpha: 1)
            color.setStroke()
        case SetCard.Color.red:
            color = #colorLiteral(red: 0.870926559, green: 0.1396642327, blue: 0, alpha: 1)
            color.setStroke()
        default:
            break
        }
        switch combinationOnCard.shape {
         case SetCard.Shape.squiggle:
            path = makeSquiggle(in: bounds)
        case SetCard.Shape.oval:
           path = makeOvals(in: bounds)
        case SetCard.Shape.diamonds:
           path = makeDiamonds(in: bounds)
        default:
            break
        }
        
        switch combinationOnCard.content {
         case SetCard.Content.filled:
            color.setFill()
            path.fill()
        case SetCard.Content.outlined:
            color.setStroke()
            path.lineWidth = 2.5
            path.stroke()
        case SetCard.Content.strided:
            path.lineWidth = 1.20
            path.stroke()
            stride()
         default:
            break
        }
     }
     private func makeDiamonds(in rectangle: CGRect) -> UIBezierPath {
        let path = UIBezierPath()
        let rect = rectangle.insetBy(dx: 0.0, dy: (rectangle.height/4))
        var topAndBottomValueForX : CGFloat = 0.0
        switch combinationOnCard.rank {
         case SetCard.Number.one:
            topAndBottomValueForX = rect.minX + widthForEachShape  * 1.5
            path.move(to: CGPoint(x: topAndBottomValueForX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.minX + widthForEachShape * 1.15 , y: rect.midY))
            path.addLine(to: CGPoint(x: topAndBottomValueForX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX + widthForEachShape * 1.85, y: rect.midY))
            path.close()
            path.addClip()
         case SetCard.Number.two:
            topAndBottomValueForX = rect.minX + widthForEachShape
            path.move(to: CGPoint(x: topAndBottomValueForX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.minX + widthForEachShape * 0.65, y: rect.midY))
            path.addLine(to: CGPoint(x: topAndBottomValueForX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX + widthForEachShape * 1.35, y: rect.midY))
            path.close()
            
            topAndBottomValueForX = rect.minX + (widthForEachShape * 2)
            
            path.move(to: CGPoint(x: topAndBottomValueForX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.minX + widthForEachShape * 1.65, y: rect.midY))
            path.addLine(to: CGPoint(x: topAndBottomValueForX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX + widthForEachShape * 2.35, y: rect.midY))
            path.close()
            
            path.addClip()
        
        case SetCard.Number.three:
            topAndBottomValueForX = rect.minX + (widthForEachShape * 0.5)
            
            path.move(to: CGPoint(x: topAndBottomValueForX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.minX + widthForEachShape * 0.15, y: rect.midY))
            path.addLine(to: CGPoint(x: topAndBottomValueForX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX + widthForEachShape * 0.85, y: rect.midY))
            path.close()
            
            topAndBottomValueForX = rect.minX + widthForEachShape * 1.5
            path.move(to: CGPoint(x: topAndBottomValueForX , y: rect.minY))
            path.addLine(to: CGPoint(x: rect.minX + widthForEachShape * 1.15, y: rect.midY))
            path.addLine(to: CGPoint(x: topAndBottomValueForX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX + widthForEachShape * 1.85, y: rect.midY))
            path.close()
            
            topAndBottomValueForX = rect.minX + widthForEachShape * 2 + widthForEachShape * 0.5
            path.move(to: CGPoint(x: topAndBottomValueForX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.minX + widthForEachShape * 2.15, y: rect.midY))
            path.addLine(to: CGPoint(x: topAndBottomValueForX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX + widthForEachShape * 2.85, y: rect.midY))
            path.close()
            
            path.addClip()
        default:
            break
        }
      return path
    }
    
    private func makeSquiggle(in rectangle: CGRect) -> UIBezierPath {
        
        let rect = rectangle.insetBy(dx: 0.0, dy: (rectangle.height / 4))
        let path = UIBezierPath()
        var startingPoint = CGPoint(x: rect.minX + widthForEachShape * 0.25, y: rect.minY)
        var endingPoint = CGPoint(x: rect.minX + widthForEachShape * 0.30, y: rect.maxY)
        var controlPoint1 = CGPoint(x: rect.minX + widthForEachShape * 0.60, y: rect.minY + 0.40 * rect.height)
        var controlPoint2 = CGPoint(x: rect.minX, y: rect.maxY - (0.20 * rect.height))
        
        switch combinationOnCard.rank {
        
        case SetCard.Number.three:
            path.move(to: startingPoint)
            path.addCurve(to: endingPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
            
             startingPoint = CGPoint(x: rect.minX + widthForEachShape * 0.65, y: rect.minY)
             endingPoint = CGPoint(x: rect.minX + widthForEachShape * 0.70, y: rect.maxY)
             controlPoint1 = CGPoint(x: rect.minX + widthForEachShape, y: rect.minY + 0.40 * rect.height)
             controlPoint2 = CGPoint(x: rect.minX + 0.30 * widthForEachShape, y: rect.maxY - (0.20 * rect.height))
            path.addLine(to: endingPoint)
            
            path.addCurve(to: startingPoint, controlPoint1: controlPoint2, controlPoint2: controlPoint1)
            path.close()
            
            /* second squiggle */
             startingPoint = CGPoint(x: rect.minX + widthForEachShape * 1.25, y: rect.minY)
             endingPoint = CGPoint(x: rect.minX + widthForEachShape * 1.30, y: rect.maxY)
             controlPoint1 = CGPoint(x: rect.minX + widthForEachShape * 1.60, y: rect.minY + 0.40 * rect.height)
             controlPoint2 = CGPoint(x: rect.minX + widthForEachShape, y: rect.maxY - (0.20 * rect.height))
            
            path.move(to: startingPoint)
            path.addCurve(to: endingPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
            
            startingPoint = CGPoint(x: rect.minX + widthForEachShape * 1.65, y: rect.minY)
            endingPoint = CGPoint(x: rect.minX + widthForEachShape * 1.70, y: rect.maxY)
            controlPoint2 = CGPoint(x: rect.minX + widthForEachShape * 2 , y: rect.minY + 0.40 * rect.height)
            controlPoint1 = CGPoint(x: rect.minX + 1.30 * widthForEachShape, y: rect.maxY - (0.20 * rect.height))
            path.addLine(to: endingPoint)
            
            path.addCurve(to: startingPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
            path.close()
            
          /* third squiggle */
            startingPoint = CGPoint(x: rect.minX + widthForEachShape * 2.25, y: rect.minY)
            endingPoint = CGPoint(x: rect.minX + widthForEachShape * 2.30, y: rect.maxY)
            controlPoint1 = CGPoint(x: rect.minX + widthForEachShape * 2.60, y: rect.minY + 0.40 * rect.height)
            controlPoint2 = CGPoint(x: rect.minX + widthForEachShape * 2, y: rect.maxY - (0.20 * rect.height))
            
            path.move(to: startingPoint)
            path.addCurve(to: endingPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
            startingPoint = CGPoint(x: rect.minX + widthForEachShape * 2.65, y: rect.minY)
            endingPoint = CGPoint(x: rect.minX + widthForEachShape * 2.70, y: rect.maxY)
            controlPoint1 = CGPoint(x: rect.minX + widthForEachShape * 3, y: rect.minY + 0.40 * rect.height)
            controlPoint2 = CGPoint(x: rect.minX + 2.30 * widthForEachShape, y: rect.maxY - (0.20 * rect.height))
            
            path.addLine(to: endingPoint)
            
            path.addCurve(to: startingPoint, controlPoint1: controlPoint2, controlPoint2: controlPoint1)
            path.close()
            path.addClip()
        case SetCard.Number.two:
            startingPoint = CGPoint(x: rect.minX + widthForEachShape * 0.65, y: rect.minY)
            endingPoint = CGPoint(x: rect.minX + widthForEachShape * 0.70, y: rect.maxY)
            controlPoint1 = CGPoint(x: rect.minX + widthForEachShape * 0.90, y: rect.minY + 0.40 * rect.height)
            controlPoint2 = CGPoint(x: rect.minX + widthForEachShape * 0.3, y: rect.maxY - (0.20 * rect.height))
            
            path.move(to: startingPoint)
            path.addCurve(to: endingPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
            
            startingPoint = CGPoint(x: rect.minX + widthForEachShape * 1.05, y: rect.minY)
            endingPoint = CGPoint(x: rect.minX + widthForEachShape * 1.15, y: rect.maxY)
            controlPoint1 = CGPoint(x: rect.minX + widthForEachShape * 1.45, y: rect.minY + 0.40 * rect.height)
            controlPoint2 = CGPoint(x: rect.minX + widthForEachShape * 0.70, y: rect.maxY - (0.20 * rect.height))
            
            path.addLine(to: endingPoint)
            path.addCurve(to: startingPoint, controlPoint1: controlPoint2, controlPoint2: controlPoint1)
            path.close()
            
            startingPoint = CGPoint(x: rect.minX + widthForEachShape * 1.65, y: rect.minY)
            endingPoint = CGPoint(x: rect.minX + widthForEachShape * 1.70, y: rect.maxY)
            controlPoint1 = CGPoint(x: rect.minX + widthForEachShape * 2 , y: rect.minY + 0.40 * rect.height)
            controlPoint2 = CGPoint(x: rect.minX + 1.30 * widthForEachShape, y: rect.maxY - (0.20 * rect.height))
            
            path.move(to: startingPoint)
            path.addCurve(to: endingPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
            startingPoint = CGPoint(x: rect.minX + widthForEachShape * 2.05, y: rect.minY)
            endingPoint = CGPoint(x: rect.minX + widthForEachShape * 2.10, y: rect.maxY)
            controlPoint1 = CGPoint(x: rect.minX + widthForEachShape * 2.45, y: rect.minY + 0.40 * rect.height)
            controlPoint2 = CGPoint(x: rect.minX + widthForEachShape * 1.70, y: rect.maxY - (0.20 * rect.height))
            path.addLine(to: endingPoint)
            path.addCurve(to: startingPoint, controlPoint1: controlPoint2, controlPoint2: controlPoint1)
            path.close()
            
            path.addClip()
            
        case SetCard.Number.one:
            startingPoint = CGPoint(x: rect.minX + widthForEachShape * 1.25, y: rect.minY)
            endingPoint = CGPoint(x: rect.minX + widthForEachShape * 1.30, y: rect.maxY)
            controlPoint1 = CGPoint(x: rect.minX + widthForEachShape * 1.75, y: rect.minY + 0.40 * rect.height)
            controlPoint2 = CGPoint(x: rect.minX + widthForEachShape, y: rect.maxY - (0.20 * rect.height))
            
            path.move(to: startingPoint)
            path.addCurve(to: endingPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
            
            startingPoint = CGPoint(x: rect.minX + widthForEachShape * 1.65, y: rect.minY)
            endingPoint = CGPoint(x: rect.minX + widthForEachShape * 1.70, y: rect.maxY)
            controlPoint2 = CGPoint(x: rect.minX + widthForEachShape * 2.15 , y: rect.minY + 0.40 * rect.height)
            controlPoint1 = CGPoint(x: rect.minX + 1.45 * widthForEachShape, y: rect.maxY - (0.20 * rect.height))
            
            path.addLine(to: endingPoint)
            path.addCurve(to: startingPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
            path.close()
            path.addClip()
            
        default:
        break
       
    }
    return path
    }
    
    private func makeOvals(in rectangle: CGRect) -> UIBezierPath{
        let path = UIBezierPath()
        let rect = rectangle.insetBy(dx: 0.0, dy: (rectangle.height/6.25))
        switch combinationOnCard.rank {
        case SetCard.Number.one:
            
            path.move(to: CGPoint(x: rect.minX + 1.15 * widthForEachShape, y: rect.minY + 0.35 * rect.height))
            path.addLine(to: CGPoint(x: rect.minX + 1.15 * widthForEachShape, y: 0.35 * rect.height + rect.minY))
            path.addArc(withCenter: CGPoint(x: 1.50 * widthForEachShape, y: rect.maxY - 0.35 * rect.height), radius: 0.35 * widthForEachShape, startAngle: CGFloat(180).toRadians(), endAngle: CGFloat(0).toRadians(), clockwise: false)
            path.addLine(to: CGPoint(x: 1.85 * widthForEachShape + rect.minX, y: rect.minY + 0.35 * rect.height))
            path.addArc(withCenter: CGPoint(x: 1.50 * widthForEachShape + rect.minX, y: rect.minY + 0.35 * rect.height), radius: 0.35 * widthForEachShape, startAngle: CGFloat(0).toRadians(), endAngle: CGFloat(180).toRadians(), clockwise: false)

           path.addClip()
        case SetCard.Number.three:
             /* firstPath */
            path.move(to: CGPoint(x: rect.minX + 0.15 * widthForEachShape, y: rect.minY + 0.35 * rect.height))
            path.addLine(to: CGPoint(x: rect.minX + 0.15 * widthForEachShape, y: 0.35 * rect.height + rect.minY))
            path.addArc(withCenter: CGPoint(x: 0.50 * widthForEachShape + rect.minX, y: rect.maxY - 0.35 * rect.height), radius: 0.35 * widthForEachShape, startAngle: CGFloat(180).toRadians(), endAngle: CGFloat(0).toRadians(), clockwise: false)
            path.addLine(to: CGPoint(x: 0.85 * widthForEachShape + rect.minX, y:rect.minY + 0.35 * rect.height))
            path.addArc(withCenter: CGPoint(x: 0.50 * widthForEachShape + rect.minX, y: rect.minY + 0.35 * rect.height), radius: 0.35 * widthForEachShape, startAngle: CGFloat(0).toRadians(), endAngle: CGFloat(180).toRadians(), clockwise: false)
            
            /* secondPath */
            path.move(to: CGPoint(x: rect.minX + 1.15 * widthForEachShape, y: rect.minY + 0.35 * rect.height))
            path.addLine(to: CGPoint(x: rect.minX + 1.15 * widthForEachShape, y: 0.35 * rect.height + rect.minY))
            path.addArc(withCenter: CGPoint(x: 1.50 * widthForEachShape, y: rect.maxY - 0.35 * rect.height), radius: 0.35 * widthForEachShape, startAngle: CGFloat(180).toRadians(), endAngle: CGFloat(0).toRadians(), clockwise: false)
            path.addLine(to: CGPoint(x: 1.85 * widthForEachShape + rect.minX, y: rect.minY + 0.35 * rect.height))
            path.addArc(withCenter: CGPoint(x: 1.50 * widthForEachShape + rect.minX, y: rect.minY + 0.35 * rect.height), radius: 0.35 * widthForEachShape, startAngle: CGFloat(0).toRadians(), endAngle: CGFloat(180).toRadians(), clockwise: false)

       /* thirdPath */
            
            path.move(to: CGPoint(x: rect.minX + 2.15 * widthForEachShape, y: rect.minY + 0.35 * rect.height))
            path.addLine(to: CGPoint(x: rect.minX + 2.15 * widthForEachShape, y: 0.35 * rect.height + rect.minY))
            path.addArc(withCenter: CGPoint(x: 2.50 * widthForEachShape, y: rect.maxY - 0.35 * rect.height), radius: 0.35 * widthForEachShape, startAngle: CGFloat(180).toRadians(), endAngle: CGFloat(0).toRadians(), clockwise: false)
            path.addLine(to: CGPoint(x: 2.85 * widthForEachShape + rect.minX, y: rect.minY + 0.35 * rect.height))
            path.addArc(withCenter: CGPoint(x: 2.50 * widthForEachShape + rect.minX, y: rect.minY + 0.35 * rect.height), radius: 0.35 * widthForEachShape, startAngle: CGFloat(0).toRadians(), endAngle: CGFloat(180).toRadians(), clockwise: false)
            
            path.addClip()

           case SetCard.Number.two:
            /* firstOval */
             path.move(to: CGPoint(x: rect.minX + 0.65 * widthForEachShape, y: rect.minY + 0.35 * rect.height))
             path.addLine(to: CGPoint(x: rect.minX + 0.65 * widthForEachShape, y: 0.35 * rect.height + rect.minY))
             path.addArc(withCenter: CGPoint(x:  widthForEachShape + rect.minX, y: rect.maxY - 0.35 * rect.height), radius: 0.35 * widthForEachShape, startAngle: CGFloat(180).toRadians(), endAngle: CGFloat(0).toRadians(), clockwise: false)
             path.addLine(to: CGPoint(x: 1.35 * widthForEachShape + rect.minX, y:rect.minY + 0.35 * rect.height))
             path.addArc(withCenter: CGPoint(x:  widthForEachShape + rect.minX, y: rect.minY + 0.35 * rect.height), radius: 0.35 * widthForEachShape, startAngle: CGFloat(0).toRadians(), endAngle: CGFloat(180).toRadians(), clockwise: false)
            /* secondOval */
             path.move(to: CGPoint(x: rect.minX + 1.65 * widthForEachShape, y: rect.minY + 0.35 * rect.height))
             path.addLine(to: CGPoint(x: rect.minX + 1.65 * widthForEachShape, y: 0.35 * rect.height + rect.minY))
             path.addArc(withCenter: CGPoint(x: 2.0 * widthForEachShape + rect.minX, y: rect.maxY - 0.35 * rect.height), radius: 0.35 * widthForEachShape, startAngle: CGFloat(180).toRadians(), endAngle: CGFloat(0).toRadians(), clockwise: false)
             path.addLine(to: CGPoint(x: 2.35 * widthForEachShape + rect.minX, y:rect.minY + 0.35 * rect.height))
             path.addArc(withCenter: CGPoint(x: 2.0 * widthForEachShape + rect.minX, y: rect.minY + 0.35 * rect.height), radius: 0.35 * widthForEachShape, startAngle: CGFloat(0).toRadians(), endAngle: CGFloat(180).toRadians(), clockwise: false)
            
            path.addClip()
            
        default:
            break
        }
        
       return path
        
    }
    private func stride() {
        let path = UIBezierPath()
        
        var rect : CGRect = frame
        switch combinationOnCard.rank {
        case SetCard.Number.one:
             rect = bounds.insetBy(dx: (bounds.width / 3), dy: (bounds.height / 4))
        
        case SetCard.Number.two:
            rect = bounds.insetBy(dx: frame.width / 6, dy: (bounds.height/4))
            
        case SetCard.Number.three:
            rect  = bounds.insetBy(dx: 0, dy: (bounds.height / 4))
        default:
            break
        }
        let startingPointForX = rect.minX
        let endingPointForX = rect.maxX
        
        var y = rect.minY + offset
        isLineAtStartingPoint = true
        while y < rect.maxY {
            if isLineAtStartingPoint {
                path.move(to: CGPoint(x: startingPointForX, y: y))
                path.addLine(to: CGPoint(x: endingPointForX, y: y))
                setLineWidthAndStrokeColor(path: path)
                isLineAtEndingPoint = true
                isLineAtStartingPoint = false
                y += offset
            }
            else if isLineAtEndingPoint {
                path.move(to: CGPoint(x: endingPointForX, y: y))
               path.addLine(to: CGPoint(x: startingPointForX, y: y))
                setLineWidthAndStrokeColor(path: path)
                isLineAtEndingPoint = false
                isLineAtStartingPoint = true
                y += offset
            }}
        
        }
    private func fillBoundingRect(inRect: UIBezierPath, color: UIColor){
        color.setFill()
        inRect.fill()
    }
    @objc func didTap(sender: UITapGestureRecognizer) {
    
    switch sender.state {
    case .ended:
        let rect = UIBezierPath(rect: bounds)
        fillBoundingRect(inRect: rect, color: UIColor.gray)
    default:
        break
    }
    }
    
    private func setLineWidthAndStrokeColor(path: UIBezierPath){
        path.lineWidth = 0.60
        path.stroke()
    }
    
    private func calculateWidth(for cardsIn: CGRect)-> CGFloat {
        return  (cardsIn.width / 3.00)
    }

}
extension CGFloat {
    func toRadians() -> CGFloat {
        return self * CGFloat(CGFloat.pi) / 180.0
    }
}

