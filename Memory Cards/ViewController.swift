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
        restartButton.setTitle("Change Level", for: .normal)
        settingTheme()
        updateViewFromModel()
    }
    
    private var themeBackgroundColor: UIColor?
    private var themeCardColor: UIColor?
    private var themeCardTitles: [String]?
    private var emoji = [Card: String]()
    
    private let halloweenTheme = Theme.init(backgroundColor: #colorLiteral(red: 0.1490196078, green: 0.1490196078, blue: 0.1490196078, alpha: 1), cardColor: #colorLiteral(red: 0.9176470588, green: 0.4588235294, blue: 0.2705882353, alpha: 1), cardTitles: ["👻","🎃", "👹", "🕷", "🕸","🦉","🦇", "🐈", "🧟‍♀️", "🐸"])
    private let happyTheme = Theme.init(backgroundColor: #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1), cardColor: #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1), cardTitles: ["🤗", "😍", "🤣", "😁", "🙆", "😘", "🙆‍♂️", "🎉", "😋", "😛"])
    private let animalsTheme = Theme.init(backgroundColor: #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1), cardColor: #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1), cardTitles: ["🦔", "🦊", "🐅", "🐒", "🦁", "🐿", "🐼", "🐷", "🐇", "🐶"])
    private let foodTheme = Theme.init(backgroundColor: #colorLiteral(red: 0.9176470588, green: 0.4588235294, blue: 0.2705882353, alpha: 1), cardColor: #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1), cardTitles: ["🍕", "🍳", "🍔", "🍟", "🧀", "🌭", "🥓", "🌯", "🍗", "🥙"])
    private let sportsTheme = Theme.init(backgroundColor: #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1), cardColor: #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1), cardTitles: ["🏈", "🏀", "🏐", "🎾", "⚾️", "🏓", "🏉", "⚽️", "🎱", "🎳"])
    private let sweetsTheme = Theme.init(backgroundColor: #colorLiteral(red: 0.5791940689, green: 0.4061957465, blue: 0.5726861358, alpha: 1), cardColor: #colorLiteral(red: 0.0006239149306, green: 0.2781304253, blue: 0.3674587674, alpha: 1), cardTitles: ["🍬", "🍪", "🍰", "🍭", "🍫", "🍯", "🍦", "🍩", "🎂", "🍡"])
    private let fruitTheme = Theme.init(backgroundColor: #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1), cardColor: #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1), cardTitles: ["🍊", "🍉", "🍒", "🍋", "🥥", "🥝", "🍍", "🍌", "🍓", "🍇"])
    @IBOutlet weak var restartButton: UIButton!
    
    private func settingTheme() {
        let themes = [halloweenTheme, happyTheme, animalsTheme ,foodTheme, sportsTheme, sweetsTheme, fruitTheme]
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

