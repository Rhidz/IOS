
import Foundation
import Foundation

struct Card: Hashable {
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    var isSelected = false
    var isMatched = false
    var identifier: Int
    var color = false
    var shape = false
    var number = false
    var content = false
    
    static var indentifierFactory = 0
    
    static func getIdentifier() -> Int {
        indentifierFactory += 1
        return indentifierFactory
    }
    
    init() {
        self.identifier = Card.getIdentifier()
    }
}
