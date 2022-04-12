//
//  ViewController.swift
//  Apple Pie
//
//  Created by Park JooHyun on 2022/04/11.
//

import UIKit

class ViewController: UIViewController {

    var listOfWords = ["buccaneer", "swift", "glorious", "incandescent", "bug", "program"]
    let incorrectMovesAllowed = 7
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }
    var totalScores = [0, 0]
    var currentGame: Game!
    var currPlayer = 0
    
    @IBOutlet var treeImageView: UIImageView!
    @IBOutlet var correctWordLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    
    @IBOutlet var players: [UILabel]!
    
    @IBOutlet var letterButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
    }
    
    func updateUI() {
        let letters = currentGame.formattedWord.map { String($0) }
        let wordWithSpacing = letters.joined(separator: " ")
        correctWordLabel.text = wordWithSpacing
        
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
                
        for (i, player) in players.enumerated() {
            player.text = "Score: \(totalScores[i])"
            player.backgroundColor = .clear
        }
        
        players[currPlayer].backgroundColor = .yellow
    }
    
    func newRound() {
        if !listOfWords.isEmpty {
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
            enableLetterButtons(true)
        } else {
            enableLetterButtons(false)
        }
        updateUI()
    }
    
    @IBAction func letterButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.configuration!.title!
        let letter = Character(letterString.lowercased())
        
        if currentGame.playerGuessed(letter: letter) {
            totalScores[currPlayer] += 1
        } else {
            turnPlayer()
        }
        
        updateGameState()
    }
    
    func enableLetterButtons(_ enable: Bool) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
    
    func updateGameState() {
        if currentGame.incorrectMovesRemaining == 0 {
            totalLosses += 1
        } else if currentGame.word == currentGame.formattedWord {
            totalScores[currPlayer] += currentGame.incorrectMovesRemaining
            totalWins += 1
        } else {
            updateUI()
        }
    }
    
    func turnPlayer() {
        currPlayer += 1
        
        if currPlayer >= totalScores.count {
            currPlayer = 0
        }
    }
}

