//
//  ViewController.swift
//  Memory Cards
//
//  Created by Eduard Caziuc on 17/03/2018.
//  Copyright © 2018 Eduard Caziuc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let themes = [Theme.halloweenTheme, Theme.happyTheme, Theme.animalsTheme ,Theme.foodTheme, Theme.sportsTheme, Theme.sweetsTheme, Theme.fruitTheme]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restartButton.setTitle("Change Level", for: .normal)
        settingTheme()
        updateViewFromModel()
    }
    
    private var themeBackgroundColor: UIColor?
    private var themeCardColor: UIColor?
    private var themeCardTitles: [String]?
    private var emoji = [Card: String]()
    
    @IBOutlet weak var restartButton: UIButton!
    
    private func settingTheme() {
        
        let randomTheme = themes.count.arc4random
        themeBackgroundColor = themes[randomTheme].backgroundColor
        themeCardColor = themes[randomTheme].cardColor
        themeCardTitles = themes[randomTheme].cardTitles
        view.backgroundColor = themeBackgroundColor
        flipCountLabel.textColor = themeCardColor
        restartButton.setTitleColor(themeCardColor, for: .normal)
        
    }
    
    let card = Card()
    
    @IBAction func restartButtonPressed(_ sender: UIButton) {
        restartButton.setTitle("Change Level", for: .normal)
        settingTheme()
        game = MemoryCardsModel(numberOfPairsOfCards: numberOfPairsOfCards)
        game.matches = 0
        updateViewFromModel()
        flipCount = 0
        updateFlipCount()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private lazy var game = MemoryCardsModel(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        
        return (cardButtons.count + 1) / 2
    }
    
    var flipCount: Int = 0
    
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    func updateFlipCount() {
        if card.isMatched == false {
            flipCountLabel.text = "Flips: \(String(flipCount))"
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
            restartButton.setTitle("Restart", for: .normal)
        }
        
        flipCount += 1
        updateFlipCount()
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
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : themeCardColor
                if button.backgroundColor == themeCardColor {
                    flipCountLabel.text = "Flips: \(String(flipCount))"
                }
                if button.backgroundColor == themeCardColor {
                    button.isEnabled = true
                }
            }
        }
    }
    
    private func emoji(for card: Card) -> String {
        
        if emoji[card] == nil, themeCardTitles != nil {
            
            emoji[card] = themeCardTitles!.remove(at: themeCardTitles!.count.arc4random)
        }
        return emoji[card] ?? "?"
    }
}
