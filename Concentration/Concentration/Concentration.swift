//
//  Concentration.swift
//  Concentration
//
//  Created by Nikhil Muskur on 08/03/18.
//  Copyright © 2018 Nikhil Muskur. All rights reserved.
//

import Foundation
import GameplayKit

class Contcentration {
    var cards = [Card]()
    var score: Int
    var flipCount: Int
    var emojiList: [String]
    var emojiThemeName: String
    var emojiThemeColor: String
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchedIndex = indexOfOneAndOnlyFaceUpCard, matchedIndex != index {
                if cards[matchedIndex].identifier == cards[index].identifier {
                    cards[matchedIndex].isMatched = true
                    cards[index].isMatched = true
                    cards[matchedIndex].isMisMatched = 0
                    cards[index].isMisMatched = 0
                }
                cards[index].isFaceup = true
                indexOfOneAndOnlyFaceUpCard = nil
            }else{
                for cardIndex in cards.indices {
                    cards[cardIndex].isFaceup = cardIndex == index
                }
                indexOfOneAndOnlyFaceUpCard = index
            }
            
        }
    }
    
    func flipCard(at index: Int) {
        //Increase the FlipCount
        flipCount += 1
        
        if !cards[index].isMatched {
            if indexOfOneAndOnlyFaceUpCard == nil {
                for cardIndex in cards.indices {
                    cards[cardIndex].isFaceup = cardIndex == index
                }
                indexOfOneAndOnlyFaceUpCard = index
            }else{
                if let previousIndex = indexOfOneAndOnlyFaceUpCard, previousIndex != index {
                    if cards[previousIndex].identifier == cards[index].identifier {
                        cards[previousIndex].isMatched = true
                        cards[index].isMatched = true
                        cards[previousIndex].isMisMatched = 0
                        cards[index].isMisMatched = 0
                    }else {
                        cards[previousIndex].isMisMatched += 1
                        cards[index].isMisMatched += 1
                    }
                    cards[index].isFaceup = true
                    indexOfOneAndOnlyFaceUpCard = nil
                }
            }
        }
    }
    
    func getFlipCount() -> Int {
        return flipCount
    }
    
    func getScore() -> Int {
        for card in cards {
            if card.isMatched, card.isFaceup {
                score += 1
            }
            if card.isMisMatched > 1, card.isFaceup, indexOfOneAndOnlyFaceUpCard == nil {
                score -= 1
            }
        }
        
        return score
    }
    
    init(numberOfPairOfCards: Int) {
        for _ in 1...numberOfPairOfCards {
            let card = Card()
            cards += [card, card]
        }
        // Shuffle the cards
        cards = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: cards) as! [Card]
        
        score = 0
        flipCount = 0
        
        // Initialize the Theme
        let theme = EmojiTheme()
        emojiList = theme.emojis
        emojiThemeName = theme.emojiThemeName
        emojiThemeColor = theme.cardTheme
    }
}


/*
 Cards Cases:
 
 case 1 :  all cards are facing down and the user is selecting his first card
 
 case 2 :  user has already selected a card and is about to choose a new card which can be matched or unmatched
 
 case 3 :  2 cards are face up and user chooses a third card so the previous two cards can be  matched so that they can be removed or faced down if they are not matched.
 
 Score cases:
 
 case 1: User flips the card for the first time so isMisMatched is not increased
 case 2: card in case 1 is paired with a non matching card , here the isM val of card is increased by 1 .
 case 3: card in case 1 is again paired with a non mactching card, here again we increase by 1 bringing the total to 2
            and giving penalty.
 case 4: if both card match are matched then the value is reduced to 0 regardless of the previous values.
 
 
 
 *?
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 */

