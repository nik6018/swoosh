//
//  ViewController.swift
//  Concentration
//
//  Created by Nikhil Muskur on 08/03/18.
//  Copyright © 2018 Nikhil Muskur. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var gameEngine = Contcentration(numberOfPairOfCards: (cardButtons.count + 1) / 2)
    var currentTheme: (emojis: [String], themeColor: UIColor)!
    
    let emojiThemeCollection = [
        "emojiSimleyChoices" : (["😨","🤩","😈","🤢","😇","😛","😍","😎","😚", "😛", "😄", "🤣", "😢", "😡", "🤮", "🤕"], UIColor.red),
        "emojiPeopleChoices" : (["👶🏽","🧛🏽‍♂️","🎅🏽","🙆🏼‍♀️","👸🏽","💆🏽‍♂️","👮🏿‍♀️","🕵🏽‍♀️","👨‍🔧", "👩‍🚀", "👨🏽‍💻", "🧛‍♀️", "👩🏽‍⚖️", "🤷🏻‍♂️", "💇🏻‍♂️", "🧜🏻‍♂️"], UIColor.blue),
        "emojiAnimalChoices" : (["🐶","🐹","🐰","🦁","🐷","🐥","🐍","🦋","🦊", "🐌", "🕷", "🦖", "🦀", "🐡", "🐫", "🐓"], UIColor.green),
        "emojiFoodChoices"   : (["🍎","🍑","🍋","🥦","🍞","🍓","🍗","🍠","🥥", "🥗", "🥖", "🍬", "🍪", "🌰", "🍿", "🍩"], UIColor.orange),
        "emojiSportChoices"  : (["⚽️","🏈","🥊","🏓","🏑","🏏","⛳️","🏂", "⚾️", "🎾", "🏀", "🏐", "🎱", "🎽", "⛸", "🎮"], UIColor.purple)
    ]
    
    override func viewDidLoad() {
        updateTheme()
    }
    
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardIndex = cardButtons.index(of: sender) {
            // this API will update our model
            gameEngine.flipCard(at: cardIndex)
            // so we need some func to update our view according to our model
            updateGameView()
        } else {
            print("Unknown card")
        }
    }
    
    @IBAction func restartTheGame(_ sender: Any) {
        gameEngine = Contcentration(numberOfPairOfCards: (cardButtons.count + 1) / 2)
        updateGameView()
        updateTheme()
    }
    
    func updateGameView() {
        // Update the cards
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = gameEngine.cards[index]
            
            if card.isFaceup {
                button.setTitle(getEmoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : currentTheme.themeColor
            }
        }
        
        // Update the FlipCount Label
        flipCountLabel.text = "Flip Count: \(gameEngine.getFlipCount())"
        scoreLabel.text = "Score : \(gameEngine.getScore())"
        
    }
    
    func updateTheme() {
        let randomIndex = Int(arc4random_uniform(UInt32(UInt(emojiThemeCollection.count))))
        self.view.backgroundColor = UIColor.black
        
        currentTheme = Array(emojiThemeCollection.values)[randomIndex]
        
        //Set the color for all the cards
        for button in cardButtons  {
            button.backgroundColor = currentTheme.themeColor
        }
        
        flipCountLabel.textColor = UIColor.white
        scoreLabel.textColor = UIColor.white
    }

    var emojiForCards = [Int:String]()
    
    func getEmoji(for card: Card) -> String {
        var emojiChoices = currentTheme.emojis
        
        if emojiForCards[card.identifier] == nil ,emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            let emoji = emojiChoices.remove(at: randomIndex)
            emojiForCards[card.identifier] = emoji
        }
        return emojiForCards[card.identifier] ?? "?"
        
    }
}









