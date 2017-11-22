//
//  ViewController.swift
//  Concentration
//
//  Created by Ly, Lien (US - Denver) on 11/21/17.
//  Copyright © 2017 Ly, Lien (US - Denver). All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    var emojiChoices = [String]()
    var emoji = [Int:String]()
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardIndex = cardButtons.index(of: sender) {
            game.chooseCard(at: cardIndex)
            
            // Match up cardButtons with "Card struct"
            updateViewFromModel()
        }
        else {
            print("Chosen card is not in cardButtons")
        }
    }
    
    @IBAction func resetGame(_ sender: UIButton) {
        getRandomTheme()
        game.resetGame()
        updateViewFromModel()
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var gameScoreLabel: UILabel!
    
    override func viewDidLoad() {
        game.addTheme(with: ["💟","☮️","✝️","☪️","🕉","♒️","☸️","✡️","🔯","🕎"])
        getRandomTheme()
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }
            else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
            }
        }
        // Update gameScoreLabel
        gameScoreLabel.text = "Score: \(game.gameScore)"
        // Update flipCountLabel
        flipCountLabel.text = "Flips: \(game.flipCount)"
    }
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        
        return emoji[card.identifier] ?? "?"
    }
    
    func getRandomTheme() {
        let randomIndex = Int(arc4random_uniform(UInt32(game.themes.count)))
        emojiChoices = game.themes[randomIndex]
        emoji = [:]
    }
}

