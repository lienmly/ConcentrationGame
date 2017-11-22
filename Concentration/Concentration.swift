//
//  Concentration.swift
//  Concentration
//
//  Created by Ly, Lien (US - Denver) on 11/21/17.
//  Copyright © 2017 Ly, Lien (US - Denver). All rights reserved.
//

import Foundation

class Concentration {
    var cards = [Card]()
    var gameScore = 0
    var indexOfOneAndOnlyFaceUpCard: Int?
    var seenCardIndices = [Int:Int]()
    var mainGameTheme = [String]()
    var themes = [["🦇","🙀","😱","😈","🎃","👻","🍭","🍬","🍎","☠️"],
                  ["🐶","🐱","🐭","🐹","🐰","🦊","🐻","🐼","🐨","🐯"],
                  ["⚽️","🏀","🏈","⚾️","🎾","🏐","🏉","🎱","🏓","🏸"],
                  ["😀","😃","😎","😡","☹️","😭","😫","😰","😍","🤪"],
                  ["🍕","🍗","🍣","🍙","🍔","🥪","🌮","🌭","🍥","🍚"],
                  ["🇩🇿","🇻🇬","🇭🇷","🇨🇼","🇨🇬","🇦🇷","🇧🇮","🇬🇪","🇸🇬","🇻🇳"]]
    
    // Public API function 
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            // -- Mark # of times this card is seen
            if seenCardIndices[index] == nil {
                seenCardIndices[index] = 1
            }
            else {
                seenCardIndices[index]! += 1
            }
            
            // -- Check the matching
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // There is 1 face up card
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    gameScore += 2
                }
                else {
                    cards[matchIndex].isMatched = false
                    cards[index].isMatched = false
                    // -- If card is seen, score decreased
                    if let numberOfTimeSeen = seenCardIndices[index], numberOfTimeSeen > 1 {
                        gameScore -= 1
                    }
                    if let numberOfTimeSeen = seenCardIndices[matchIndex], numberOfTimeSeen > 1 {
                        gameScore -= 1
                    }
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            }
            else {
                // There are 2 face up card, or no face up card
                // -- Flip all the cards down
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                // -- Flip the current card up
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    // Public API function
    func resetGame() {
        for index in cards.indices {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
        }
        indexOfOneAndOnlyFaceUpCard = nil
        cards = shuffleCards()
        gameScore = 0
        seenCardIndices = [:]
    }
    
    // Public API function
    func addTheme(with themeArray: [String]) {
        themes.append(themeArray)
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        // Shuffle the cards
        cards = shuffleCards()
    }
    
    private func shuffleCards() -> [Card]{
        var shuffledCards = [Card]()
        
        for _ in cards.indices {
            let randomIndex = Int(arc4random_uniform(UInt32(cards.count)))
            shuffledCards.append(cards.remove(at: randomIndex))
        }
        
        return shuffledCards
    }
}
