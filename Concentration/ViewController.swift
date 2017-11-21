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
    var emojiChoices = ["🦇","🙀","😱","😈","🎃","👻","🍭","🍬","🍎","☠️"]
    var emoji = [Int:String]()
    
    // Number of times cards are flipped
    var flipCount: Int = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
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
        game.resetGame()
        flipCount = 0
        updateViewFromModel()
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    
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
    }
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        
        return emoji[card.identifier] ?? "?"
    }
}

