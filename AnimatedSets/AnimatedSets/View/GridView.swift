import UIKit

@IBDesignable
class GridView: UIView {
   
   private(set) lazy var deckOfCards = createDeck()
    
   lazy var grid = Grid(layout: Grid.Layout.fixedCellSize(CGSize(width: 128.0, height: 110.0)), frame: CGRect(origin: CGPoint(x: bounds.minX, y: bounds.minY), size: CGSize(width: bounds.width, height: bounds.height)))
   
    private(set) lazy var listOfSetCards = createSetCards()
    
    private func createDeck() -> [SetCard]{
         var deck = [SetCard]()
        for shape in SetCard.Shape.allShape {
            for color in SetCard.Color.allColor {
                for content in SetCard.Content.allContent {
                    for number in SetCard.Number.allNumbers {
                        deck.append(SetCard(shape: shape, color: color, content: content, rank: number))
                    }
                }
            }
        }
        deck.shuffle()
        return deck
    }
    @IBInspectable
    var cardsOnScreen:Int = 12 { didSet { setNeedsLayout() } }
   
     private func createSetCards() -> [SetView]{
        var cards = [SetView]()
        for _ in 0..<cardsOnScreen {
            let card = SetView()
            let contentsToBeDrawn = deckOfCards.removeFirst()
            card.combinationOnCard.shape = contentsToBeDrawn.shape
            card.combinationOnCard.color = contentsToBeDrawn.color
            card.combinationOnCard.content = contentsToBeDrawn.content
            card.combinationOnCard.rank = contentsToBeDrawn.rank
            print(card.identifier)
            let tapGestureRecognizer = UITapGestureRecognizer(target: card, action: #selector(card.didTap(sender:)))
            card.isUserInteractionEnabled = true
            card.addGestureRecognizer(tapGestureRecognizer)
            addSubview(card)
            cards.append(card)
            print("I want to know if I am here")
            
        }
        return cards
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
     func addCardsOnView() {
        for _ in 1...3 {
            let card = SetView()
            let contentsToBeDrawn = deckOfCards.removeFirst()
            card.combinationOnCard.shape = contentsToBeDrawn.shape
            card.combinationOnCard.color = contentsToBeDrawn.color
            card.combinationOnCard.content = contentsToBeDrawn.content
            card.combinationOnCard.rank = contentsToBeDrawn.rank
            let tapGestureRecognizer = UITapGestureRecognizer(target: card, action: #selector(card.didTap(sender:)))
            card.isUserInteractionEnabled = true
            card.addGestureRecognizer(tapGestureRecognizer)
            addSubview(card)
            listOfSetCards.append(card)
        }
        cardsOnScreen += 3
        if cardsOnScreen <= 24 {
        grid = Grid(layout: Grid.Layout.fixedCellSize(CGSize(width: 122.0, height: 100.0)), frame: CGRect(origin: CGPoint(x: bounds.minX, y: bounds.minY), size: CGSize(width: bounds.width, height: bounds.height)))
        setNeedsLayout()
        }
        else {
           /* grid = Grid(layout: Grid.Layout.fixedCellSize(CGSize(width: 115.0, height: 70.0)), frame: CGRect(origin: CGPoint(x: bounds.minX, y: bounds.minY), size: CGSize(width: bounds.width, height: bounds.height)))*/
            grid = Grid(layout: Grid.Layout.dimensions(rowCount: 12, columnCount: 3), frame: bounds)
            setNeedsDisplay()
            setNeedsLayout()
        }
    }
}
