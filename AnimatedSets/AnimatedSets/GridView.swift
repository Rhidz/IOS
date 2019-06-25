import UIKit

class GridView: UIView {
    
   lazy var grid = Grid(layout: Grid.Layout.fixedCellSize(CGSize(width: 125.0, height: 180.0)), frame: CGRect(origin: CGPoint(x: bounds.minX, y: bounds.minY), size: CGSize(width: bounds.width, height: bounds.height)))
   
   
    
    lazy var listOfSetCard = createSetCards()
    var cardsOnScreen = 12 { didSet {setNeedsLayout()}}
    
    var trackOfCards: Int {
        get {
            return cardsOnScreen
        }
        set(newValue) {
            self.trackOfCards = newValue
        }
    }
    
    private func createSetCards() -> [SetView] {
        var cards = [SetView]()
        for _ in 0..<cardsOnScreen {
            let card = SetView()
            addSubview(card)
            cards.append(card)
        }
        print("I am here")
        return cards
    }
   
  /*  private func countTheNumberOfCards() -> Int {
       
        if !cardsFlag && !listOfSetCard.isEmpty {
            cardsOnScreen = 12
            setNeedsLayout()
            cardsFlag = true
        }
        print("But I come here first")
        return cardsOnScreen
        
    } */
    /* I can directly add call setNeedsLayout and have number of functions inside it */
    override func layoutSubviews() {
        super.layoutSubviews()
        for index in listOfSetCard.indices {
            let card = listOfSetCard[index]
            if let rect = grid[index] {
                card.frame = rect
                card.frame.origin = rect.origin
                print(card.frame.origin)
            }
        }
    }
    override func draw(_ rect: CGRect) {
         let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: 15.0)
         let color = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
         color.setFill()
         roundedRect.fill()
    }
}
