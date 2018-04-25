//
//  ViewController.swift
//  Memory Cards
//
//  Created by Eduard Caziuc on 17/03/2018.
//  Copyright © 2018 Eduard Caziuc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restartButton.isHidden = true
        
    }
    
    @IBOutlet weak var restartButton: UIButton!
    
    let card = Card()
    
    @IBAction func restartButtonPressed(_ sender: UIButton) {
        restartButton.isHidden = true
        
        game = MemoryCardsModel(numberOfPairsOfCards: numberOfPairsOfCards)
        game.matches = 0
        updateViewFromModel()
        flipCount = 0
        updateFlipCountLabel()
        
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private lazy var game = MemoryCardsModel(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
       
        return (cardButtons.count + 1) / 2
        
    }
       
    private(set) var flipCount: Int = 0 {
        
        didSet {
            
            updateFlipCountLabel()
        }
    }
    
    private func updateFlipCountLabel() {
        let attributes: [NSAttributedStringKey: Any] = [
            .strokeWidth: 5.0,
            .strokeColor: #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "Flips: \(flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attributedString
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet {
            updateFlipCountLabel()
        }
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }else {
            print("The chosen card was not in the 'cardButtons' array")
        }
        if game.matches == numberOfPairsOfCards {
            restartButton.isHidden = false
        }
        flipCount += 1
    }
    
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
           let button = cardButtons[index]
           let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                button.isEnabled = false
            }else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
                button.isEnabled = true
            }
        }
    }
    
    private var emojiChoices = ["👻","🎃", "👹", "🕷", "🕸","🦉","🦇", "🐈", "🧟‍♀️", "🐸"]
    
    private var emoji: [Card : String] = [ : ]
    
    private func emoji(for card: Card) -> String {
        
            if emoji[card] == nil, emojiChoices.count > 0 {
             
            emoji[card] = emojiChoices.remove(at: emojiChoices.count.arc4random)
            }
        return emoji[card] ?? "?"
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

