//
//  Theme.swift
//  Concentration
//
//  Created by Nikhil Muskur on 10/03/18.
//  Copyright © 2018 Nikhil Muskur. All rights reserved.
//

import Foundation

struct EmojiTheme {
    var emojis: [String]
    let emojiThemeName: String
    let cardTheme: String
    
    static let colorTheme = ["red", "green", "blue", "orange", "purple", "yellow"]
    /*
    static let emojiCollection = [
        "emojiChoices"       : ["😨","🤩","😈","🤢","🐽","🍺","❤️","🎈"],
        "emojiSimleyChoices" : ["😨","🤩","😈","🤢","😇","😛","😍","😎"],
        "emojiPeopleChoices" : ["👶🏽","🧛🏽‍♂️","🎅🏽","🙆🏼‍♀️","👸🏽","💆🏽‍♂️","👮🏿‍♀️","🕵🏽‍♀️"],
        "emojiAnimalChoices" : ["🐶","🐹","🐰","🦁","🐷","🐥","🐍","🦋"],
        "emojiFoodChoices"   : ["🍎","🍑","🍋","🥦","🍞","🍓","🍗","🍠"],
        "emojiSportChoices"  : ["⚽️","🏈","🥊","🏓","🏑","🏏","⛳️","🏂"]
    ]*/
    
    static let emojiCollection = [
        "emojiSimleyChoices" : ["😨","🤩","😈","🤢","😇","😛","😍","😎","😚", "😛", "😄", "🤣", "😢", "😡", "🤮", "🤕"],
        "emojiPeopleChoices" : ["👶🏽","🧛🏽‍♂️","🎅🏽","🙆🏼‍♀️","👸🏽","💆🏽‍♂️","👮🏿‍♀️","🕵🏽‍♀️","👨‍🔧", "👩‍🚀", "👨🏽‍💻", "🧛‍♀️", "👩🏽‍⚖️", "🤷🏻‍♂️", "💇🏻‍♂️", "🧜🏻‍♂️"],
        "emojiAnimalChoices" : ["🐶","🐹","🐰","🦁","🐷","🐥","🐍","🦋","🦊", "🐌", "🕷", "🦖", "🦀", "🐡", "🐫", "🐓"],
        "emojiFoodChoices"   : ["🍎","🍑","🍋","🥦","🍞","🍓","🍗","🍠","🥥", "🥗", "🥖", "🍬", "🍪", "🌰", "🍿", "🍩"],
        "emojiSportChoices"  : ["⚽️","🏈","🥊","🏓","🏑","🏏","⛳️","🏂", "⚾️", "🎾", "🏀", "🏐", "🎱", "🎽", "⛸", "🎮"]
    ]
    
    init() {
        // Get a Random Index
        let randomTheme = Int(arc4random_uniform(UInt32(EmojiTheme.emojiCollection.count)))
        // Initialize all the theme related vars
        emojiThemeName = Array(EmojiTheme.emojiCollection.keys)[randomTheme]
        emojis = Array(EmojiTheme.emojiCollection.values)[randomTheme]
        cardTheme = EmojiTheme.colorTheme[randomTheme]
    }
    
}

