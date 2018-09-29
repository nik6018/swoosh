//
//  ViewController.swift
//  Concentration
//
//  Created by Nikhil Muskur on 08/03/18.
//  Copyright © 2018 Nikhil Muskur. All rights reserved.
//

//TODO :
// 1. In emojiThemeCollection the emojis must be string and not an array od string
// 2. Fix the Scoring system code in model
// 3. Fix restart button position in landscape
// 4. Add atrributes to Restart button

import UIKit

class ConcentrationViewController: UIViewController {
    
    private lazy var gameEngine = Contcentration(numberOfPairOfCards: numberOfCards)
    
    //since the property is get only no need for private(set)
    var numberOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.largeTitleDisplayMode = .never
        
        if let tbc = tabBarController {
            print("TBC found")
            if let svc = tbc.navigationController {
                print("SVC found")
                if let _ = svc.navigationController {
                    print("NVC found")
                } else {
                    print("Can't find")
                }
            } else {
                print("Cannot find NVC in TBC what the FCK is going on")
            }
        } else {
            print("Not FOund Can;t say where the fuck are wee")
        }
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Restart", style: .plain, target: self, action: #selector(restartTheGame))
        
        let arrImage = UIImageView(image: #imageLiteral(resourceName: "arrow"))
        arrImage.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        arrImage.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        
        let vw = UIView()
        vw.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        vw.addSubview(arrImage)
        
        navigationItem.titleView = vw
        
//        navigationItem.backBarButtonItem = UIBarButtonItem(customView: vw)
        
//        navigationItem.titleView?.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        
        // Don't set this if using a custom back button, below overrides that
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "left", style: .plain, target: nil, action: nil)
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet private weak var scoreLabel: UILabel!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardIndex = cardButtons.index(of: sender) {
            // this API will update our model
            gameEngine.flipCard(at: cardIndex)
            // so we need some func to update our view according to our model
            updateGameView()
        } else {
            print("Unknown card")
        }
    }
    
    @objc @IBAction private func restartTheGame(_ sender: Any) {
        gameEngine = Contcentration(numberOfPairOfCards: (cardButtons.count + 1) / 2)
        updateGameView()
        updateTheme()
    }
    
    private func updateGameView() {
        // Update the cards
//        if currentTheme != nil {
            for index in cardButtons.indices {
                let button = cardButtons[index]
                let card = gameEngine.cards[index]
                
                if card.isFaceup {
                    button.setTitle(getEmoji(for: card), for: .normal)
                    button.backgroundColor = #colorLiteral(red: 0.6677756906, green: 0.6667363644, blue: 0.6677559018, alpha: 1)
                }else {
                    button.setTitle("", for: .normal)
                    button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : currentTheme?.themeColor ?? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                }
            }
//        }
        
        // Update the FlipCount Label
        updateTheFlipCountLabel()
        scoreLabel.text = "Score : \(gameEngine.getScore())"
        
    }
    
    private func updateTheme() {
        self.view.backgroundColor = UIColor.black
        self.navigationItem.rightBarButtonItem?.tintColor = currentTheme?.themeColor ?? UIColor.blue
        scoreLabel.textColor = UIColor.white
        updateTheFlipCountLabel()
    }
    
    func updateTheFlipCountLabel() {
        let stringAttributes: [NSAttributedStringKey:Any] = [
            .strokeWidth: 5.0,
            .strokeColor: currentTheme?.themeColor ?? UIColor.black
        ]
        
        let attributedString = NSAttributedString(string: "Flip Count: \(gameEngine.flipCount)", attributes: stringAttributes)
        
        flipCountLabel.attributedText = attributedString
    }
    
    var currentTheme: (emojis: String, themeColor: UIColor)? {
        didSet {
            emojiChoices = currentTheme?.emojis ?? ""
            emojiForCards = [:]
            updateTheme()
            updateGameView()
        }
    }
    

    private var emojiForCards = [Card:String]()
    private var emojiChoices = "😨🤩😈🎅🏽🙆🏼‍♀️👸🏽⚾️🎾🏀🍬🍪🐶🐹🐰🦁"
    
    private func getEmoji(for card: Card) -> String {
        
        if emojiForCards[card] == nil ,emojiChoices.count > 0 {
            let randomIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            let emoji = String(emojiChoices.remove(at: randomIndex))
            emojiForCards[card] = emoji
        }
        return emojiForCards[card] ?? "?"
        
    }
}		


extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
