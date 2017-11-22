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
    var colorTheme = [UIColor]()
    
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
        game.resetGame()
        updateViewFromModel()
        colorTheme = []
        getRandomTheme()
        setColorTheme()
    }
    
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var gameScoreLabel: UILabel!
    
    override func viewDidLoad() {
        game.addTheme(name: "WeirdSymbol", with: ["💟","☮️","✝️","☪️","🕉","♒️","☸️","✡️","🔯","🕎"], color: [(135, 5, 135, 1),(232, 157, 232, 1)])
        getRandomTheme()
        setColorTheme()
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
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : colorTheme[0]
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
        let themeKeys = Array(game.themes.keys)
        emojiChoices = game.themes[themeKeys[randomIndex]]!.0
        emoji = [:]
        
        // Set color
        let cardColor = game.themes[themeKeys[randomIndex]]!.1[0]
        let bgColor = game.themes[themeKeys[randomIndex]]!.1[1]
        let convertedCardColor = UIColor(red: CGFloat(cardColor.0/255.00), green: CGFloat(cardColor.1/255.00), blue: CGFloat(cardColor.2/255.00), alpha: CGFloat(cardColor.3))
        let convertedBGColor = UIColor(red: CGFloat(bgColor.0/255.00), green: CGFloat(bgColor.1/255.00), blue: CGFloat(bgColor.2/255.00), alpha: CGFloat(bgColor.3))
        colorTheme += [convertedCardColor, convertedBGColor]
    }
    
    func setColorTheme() {
        print("Setting color theme -- \(emojiChoices) -- for the game")
        view.backgroundColor = colorTheme[1]
        for button in cardButtons {
            button.backgroundColor = colorTheme[0]
        }
        flipCountLabel.textColor = colorTheme[0]
        gameScoreLabel.textColor = colorTheme[0]
        resetButton.backgroundColor = colorTheme[0]
        
        print("Background color = \(colorTheme[1])")
        print("Card color = \(colorTheme[0])")
    }
}

