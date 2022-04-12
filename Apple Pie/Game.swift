//
//  Game.swift
//  Apple Pie
//
//  Created by Park JooHyun on 2022/04/11.
//

import Foundation

struct Game {
    var word: String
    var incorrectMovesRemaining: Int
    var score: Int
    var guessedLetters: [Character]
    
    var formattedWord: String {
        var guessedWord = ""
        
        for letter in word {
            if guessedLetters.contains(letter) {
                guessedWord += "\(letter)"
            } else {
                guessedWord += "_"
            }
        }
        
        return guessedWord
    }
    
    mutating func playerGuessed(letter: Character) {
        guessedLetters.append(letter)
        
        if word.contains(letter) {
            score += 1
        } else {
            incorrectMovesRemaining -= 1
        }
    }
}
