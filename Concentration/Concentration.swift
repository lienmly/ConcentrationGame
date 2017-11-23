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
    var flipCount = 0
    var indexOfOneAndOnlyFaceUpCard: Int?
    var seenCardIndices = [Int:Int]()
    var mainGameTheme = [String]()
    var themes: [String:([String],[(Double, Double, Double, Double)])] = [
        // Theme Name, Theme Content, Card Color, BG Color
        "Haloween": (["🦇","🙀","😱","😈","🎃","👻","🍭","🍬","🍎","☠️"],[(244, 146, 66, 1),(0, 0, 0, 1)]),
        "Animal":   (["🐶","🐱","🐭","🐹","🐰","🦊","🐻","🐼","🐨","🐯"],[(244, 117, 236, 1),(201, 6, 201, 1)]),
        "Sport":    (["⚽️","🏀","🏈","⚾️","🎾","🏐","🏉","🎱","🏓","🏸"],[(160, 255, 195, 1),(137, 180, 249, 1)]),
        "EmojiFace":(["😀","😃","😎","😡","☹️","😭","😫","😰","😍","🤪"],[(252, 234, 100, 1),(244, 138, 93, 1)]),
        "Food":     (["🍕","🍗","🍣","🍙","🍔","🥪","🌮","🌭","🍥","🍚"],[(188, 255, 251, 1),(188, 194, 255, 1)]),
        "Flag":     (["🇩🇿","🇻🇬","🇭🇷","🇨🇼","🇨🇬","🇦🇷","🇧🇮","🇬🇪","🇸🇬","🇻🇳"],[(226, 209, 56, 1),(242, 38, 38, 1)])
    ]
    var firstTimePoint = Date()
    
    // Public API function 
    func chooseCard(at index: Int) {
        // Increment flip count
        flipCount += 1
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
                    
                    // Initialize 2nd time point & calculate time interval
                    let secondTimePoint = Date()
                    let timeInterval = secondTimePoint.timeIntervalSince(firstTimePoint)
                    let timeIntervalIndex = 100 / timeInterval
                    gameScore += Int(timeIntervalIndex)
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
                
                // Initialize or reset 1st time point
                firstTimePoint = Date()
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
        flipCount = 0
        seenCardIndices = [:]
    }
    
    // Public API function
    func addTheme(name themeName: String, with themeArray: [String], color themeColor: [(Double, Double, Double, Double)]) {
        let themeContent = (themeArray, themeColor)
        themes.updateValue(themeContent, forKey: themeName)
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
