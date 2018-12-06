//
//  Theme.swift
//  Memory Cards
//
//  Created by Eduard Caziuc on 31/05/2018.
//  Copyright © 2018 Eduard Caziuc. All rights reserved.
//

import UIKit

struct Theme {
    
    static let halloweenTheme = Theme.init(backgroundColor: #colorLiteral(red: 0.1490196078, green: 0.1490196078, blue: 0.1490196078, alpha: 1), cardColor: #colorLiteral(red: 0.9176470588, green: 0.4588235294, blue: 0.2705882353, alpha: 1), cardTitles: ["👻","🎃", "👹", "🕷", "🕸","🦉","🦇", "🐈", "🧟‍♀️", "🐸"])
    static let happyTheme = Theme.init(backgroundColor: #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1), cardColor: #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1), cardTitles: ["🤗", "😍", "🤣", "😁", "🙆", "😘", "🙆‍♂️", "🎉", "😋", "😛"])
    static let animalsTheme = Theme.init(backgroundColor: #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1), cardColor: #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1), cardTitles: ["🦔", "🦊", "🐅", "🐒", "🦁", "🐿", "🐼", "🐷", "🐇", "🐶"])
    static let foodTheme = Theme.init(backgroundColor: #colorLiteral(red: 0.9176470588, green: 0.4588235294, blue: 0.2705882353, alpha: 1), cardColor: #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1), cardTitles: ["🍕", "🍳", "🍔", "🍟", "🧀", "🌭", "🥓", "🌯", "🍗", "🥙"])
    static let sportsTheme = Theme.init(backgroundColor: #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1), cardColor: #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1), cardTitles: ["🏈", "🏀", "🏐", "🎾", "⚾️", "🏓", "🏉", "⚽️", "🎱", "🎳"])
    static let sweetsTheme = Theme.init(backgroundColor: #colorLiteral(red: 0.5791940689, green: 0.4061957465, blue: 0.5726861358, alpha: 1), cardColor: #colorLiteral(red: 0.0006239149306, green: 0.2781304253, blue: 0.3674587674, alpha: 1), cardTitles: ["🍬", "🍪", "🍰", "🍭", "🍫", "🍯", "🍦", "🍩", "🎂", "🍡"])
    static let fruitTheme = Theme.init(backgroundColor: #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1), cardColor: #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1), cardTitles: ["🍊", "🍉", "🍒", "🍋", "🥥", "🥝", "🍍", "🍌", "🍓", "🍇"])
    
    var backgroundColor: UIColor
    var cardColor: UIColor
    var cardTitles: [String]
    
}
