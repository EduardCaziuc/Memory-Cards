//
//  MemoryCardsModel.swift
//  Memory Cards
//
//  Created by Eduard Caziuc on 18/03/2018.
//  Copyright © 2018 Eduard Caziuc. All rights reserved.
//

import Foundation

struct MemoryCardsModel {
    
    private(set) var cards = [Card]() //or var cards = [Card]()
    var matches = 0
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    }else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    mutating func resetCards() {
        cards.removeAll()
    }
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Memory Cards.chosenCard(at: \(index)): chosen index not in the cards")
        
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                //check if cards match
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    matches += 1
                }
                cards[index].isFaceUp = true
            }else {
                //either no cards or 2 cards are face up
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Memory Cards.init( \(numberOfPairsOfCards)): you must have at least one pair of cards")
        
        for _ in 1...numberOfPairsOfCards {
            
            let card = Card()
            cards += [card, card]
        }
        
        // TODO: Shufle the cards (HomeWork)
        for _ in cards {
            let randomIndex = cards.count.arc4random
            let randomCard = cards.remove(at: randomIndex)
            cards.append(randomCard)
        }
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        }else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        }else {
            return 0
        }
    }
}
