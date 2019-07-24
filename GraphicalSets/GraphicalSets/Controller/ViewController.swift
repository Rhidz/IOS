import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // create cards in model
        gridView.frame = CGRect(x: 0.0, y: 40.0, width: 415, height: 800)
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(addCards))
        swipe.direction = .up
        gridView.addGestureRecognizer(swipe)
        self.view.addSubview(gridView)
        createDeck()
        gridView.cardsOnScreen = 12
        createSetCards(ofAmount: gridView.cardsOnScreen)
        makeCards()
    }
    
    lazy var game = SetGame()
    let gridView = GridView()
    var indices : [Int] = [0]
    
    var deckOfCards = [SetCard]()
    
    private func makeCards(){
        for _ in 0..<gridView.cardsOnScreen {
            if let card = game.drawModelCard() {
                game.playingCards.append(card)
            }
        }
    }
    
    private func createDeck() {
        
        for shape in SetCard.Shape.allShape {
            for color in SetCard.Color.allColor {
                for content in SetCard.Content.allContent {
                    for number in SetCard.Number.allNumbers {
                        deckOfCards.append(SetCard(shape: shape, color: color, content: content, rank: number))
                    }
                }
            }
        }
        deckOfCards.shuffle()
        
    }
    
    private func createSetCards(ofAmount: Int){
        
        for i in 0..<ofAmount {
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
            card.delegate = self
            gridView.addSubview(card)
            if  indices.count == 3 {
                //print(gridView.listOfSetCards[indices[i]])
                gridView.listOfSetCards[indices[i]] = card
            } else {
                gridView.listOfSetCards.append(card)
            }
            
            gridView.setNeedsLayout()
        }
        
    }
    
    @objc func addCards() {
        addCardsOnView()
    }
    private func compareColor(card0: SetView, card1: SetView, card2: SetView){
        let allColorsMatch = (card0.combinationOnCard.color == card1.combinationOnCard.color) && (card0.combinationOnCard.color == card2.combinationOnCard.color) && (card1.combinationOnCard.color == card2.combinationOnCard.color)
        
        let zeroAndOneMatch = card0.combinationOnCard.color == card1.combinationOnCard.color
        let oneAndTwoMatch = card1.combinationOnCard.color == card2.combinationOnCard.color
        let zeroAndTwoMatch = card0.combinationOnCard.color == card2.combinationOnCard.color
        
        updateChosenCards(allMatch: allColorsMatch, zeroAndOneMatch: zeroAndOneMatch, oneAndTwoMatch: oneAndTwoMatch, zeroAndTwoMatch: zeroAndTwoMatch)
        
    }
    private func compareRank(card0: SetView, card1: SetView, card2: SetView){
        let allColorsMatch = (card0.combinationOnCard.rank == card1.combinationOnCard.rank) && (card0.combinationOnCard.rank == card2.combinationOnCard.rank) && (card1.combinationOnCard.rank == card2.combinationOnCard.rank)
        
        let zeroAndOneMatch = card0.combinationOnCard.rank == card1.combinationOnCard.rank
        let oneAndTwoMatch = card1.combinationOnCard.rank == card2.combinationOnCard.rank
        let zeroAndTwoMatch = card0.combinationOnCard.rank == card2.combinationOnCard.rank
        
        updateChosenCards(allMatch: allColorsMatch, zeroAndOneMatch: zeroAndOneMatch, oneAndTwoMatch: oneAndTwoMatch, zeroAndTwoMatch: zeroAndTwoMatch)
        
    }
    private func compareShape(card0: SetView, card1: SetView, card2: SetView){
        let allColorsMatch = (card0.combinationOnCard.shape == card1.combinationOnCard.shape) && (card0.combinationOnCard.shape == card2.combinationOnCard.shape) && (card1.combinationOnCard.shape == card2.combinationOnCard.shape)
        
        let zeroAndOneMatch = card0.combinationOnCard.shape == card1.combinationOnCard.shape
        let oneAndTwoMatch = card1.combinationOnCard.shape == card2.combinationOnCard.shape
        let zeroAndTwoMatch = card0.combinationOnCard.shape == card2.combinationOnCard.shape
        
        updateChosenCards(allMatch: allColorsMatch, zeroAndOneMatch: zeroAndOneMatch, oneAndTwoMatch: oneAndTwoMatch, zeroAndTwoMatch: zeroAndTwoMatch)
        
    }
    private func compareContent(card0: SetView, card1: SetView, card2: SetView){
        let allColorsMatch = (card0.combinationOnCard.content == card1.combinationOnCard.content) && (card0.combinationOnCard.content == card2.combinationOnCard.content) && (card1.combinationOnCard.content == card2.combinationOnCard.content)
        
        let zeroAndOneMatch = card0.combinationOnCard.content == card1.combinationOnCard.content
        let oneAndTwoMatch = card1.combinationOnCard.content == card2.combinationOnCard.content
        let zeroAndTwoMatch = card0.combinationOnCard.content == card2.combinationOnCard.content
        
       updateChosenCards(allMatch: allColorsMatch, zeroAndOneMatch: zeroAndOneMatch, oneAndTwoMatch: oneAndTwoMatch, zeroAndTwoMatch: zeroAndTwoMatch)
        
    }
    
    private func updateChosenCards (allMatch: Bool, zeroAndOneMatch: Bool, oneAndTwoMatch: Bool, zeroAndTwoMatch: Bool) {
        
        game.playingCards[game.indicesOfChosenCards[0]].color = allMatch || zeroAndOneMatch || zeroAndTwoMatch
        game.playingCards[game.indicesOfChosenCards[1]].color = allMatch || zeroAndOneMatch || oneAndTwoMatch
        game.playingCards[game.indicesOfChosenCards[2]].color = allMatch || zeroAndTwoMatch || oneAndTwoMatch
        
        game.playingCards[game.indicesOfChosenCards[0]].number = allMatch || zeroAndOneMatch || zeroAndTwoMatch
        game.playingCards[game.indicesOfChosenCards[1]].number = allMatch || zeroAndOneMatch || oneAndTwoMatch
        game.playingCards[game.indicesOfChosenCards[2]].number = allMatch || zeroAndTwoMatch || oneAndTwoMatch
        
        game.playingCards[game.indicesOfChosenCards[0]].shape = allMatch || zeroAndOneMatch || zeroAndTwoMatch
        game.playingCards[game.indicesOfChosenCards[1]].shape = allMatch || zeroAndOneMatch || oneAndTwoMatch
        game.playingCards[game.indicesOfChosenCards[2]].shape = allMatch || zeroAndTwoMatch || oneAndTwoMatch
        
        game.playingCards[game.indicesOfChosenCards[0]].content = allMatch || zeroAndOneMatch || zeroAndTwoMatch
        game.playingCards[game.indicesOfChosenCards[1]].content = allMatch || zeroAndOneMatch || oneAndTwoMatch
        game.playingCards[game.indicesOfChosenCards[2]].content = allMatch || zeroAndTwoMatch || oneAndTwoMatch
    }
    
    private func checkContentsForMatching(forIndex: Int) {
        compareColor(card0: gridView.listOfSetCards[game.indicesOfChosenCards[0]], card1: gridView.listOfSetCards[game.indicesOfChosenCards[1]], card2: gridView.listOfSetCards[game.indicesOfChosenCards[2]])
        
        compareRank(card0: gridView.listOfSetCards[game.indicesOfChosenCards[0]], card1: gridView.listOfSetCards[game.indicesOfChosenCards[1]], card2: gridView.listOfSetCards[game.indicesOfChosenCards[2]])
        
        compareShape(card0: gridView.listOfSetCards[game.indicesOfChosenCards[0]], card1: gridView.listOfSetCards[game.indicesOfChosenCards[1]], card2: gridView.listOfSetCards[game.indicesOfChosenCards[2]])
        
        compareContent(card0: gridView.listOfSetCards[game.indicesOfChosenCards[0]], card1: gridView.listOfSetCards[game.indicesOfChosenCards[1]], card2: gridView.listOfSetCards[game.indicesOfChosenCards[2]])
        game.matchCards(indexOf4thCard: forIndex)
        updateView()
        
        
    }
    
    private func updateView() {
        for index in game.playingCards.indices {
            if game.playingCards[index].isSelected && !game.playingCards[index].isMatched {
                gridView.updateView(atIndex: index, isSelected: true, isMatched: false)
                gridView.listOfSetCards[index].setNeedsDisplay()
                /* need to change this */
                
            }
            else if game.playingCards[index].isSelected && game.playingCards[index].isMatched {
                gridView.updateView(atIndex: index, isSelected: true, isMatched: true)
                gridView.listOfSetCards[index].removeFromSuperview()
                
            }
            else if !game.playingCards[index].isSelected && !game.playingCards[index].isMatched {
                gridView.updateView(atIndex: index, isSelected: false, isMatched: false)
                gridView.listOfSetCards[index].setNeedsDisplay()
            }
        }
    }
    
    func addCardsOnView() {
        indices = game.dealCards()
        print(indices)
        createSetCards(ofAmount: 3)
        gridView.cardsOnScreen += 3
        if gridView.cardsOnScreen <= 24 {
            gridView.grid = Grid(layout: Grid.Layout.fixedCellSize(CGSize(width: 128.0, height: 100.0)), frame: CGRect(origin: CGPoint(x: gridView.bounds.minX, y: gridView.bounds.minY), size: CGSize(width: gridView.bounds.width, height: gridView.bounds.height)))
            
            gridView.setNeedsLayout()
        }
        else {
            gridView.grid = Grid(layout: Grid.Layout.fixedCellSize(CGSize(width: 120.0, height: 85.0)), frame: CGRect(origin: CGPoint(x: gridView.bounds.minX, y: gridView.bounds.minY), size: CGSize(width: gridView.bounds.width, height: gridView.bounds.height)))
            
            gridView.setNeedsLayout()
        }
        
    }
    
}


extension ViewController: SetViewDelegate {
    
    func identifier(ofCard: Int) {
        for index in game.playingCards.indices {
            if ofCard == game.playingCards[index].identifier {
                
                if let indice = game.touchCard(chosenCard: index) {
                    checkContentsForMatching(forIndex: indice)
                    
                }
                else {
                    updateView()
                    
                }
                
            }
        }
        
    }
}

