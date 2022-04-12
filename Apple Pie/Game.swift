//
//  Game.swift
//  Apple Pie
//
//  Created by Park JooHyun on 2022/04/11.
//

import Foundation

struct Game {
    var word: String // 현재 라운드 단어
    var incorrectMovesRemaining: Int // 남은 기회 수
    var guessedLetters: [Character] // 플레이어가 선택한 알파벳 기록
    
    // 단어에서 현재까지 맞춘 알파벳 오픈
    var formattedWord: String {
        var guessedWord = ""
        
        for letter in word {
            if guessedLetters.contains(letter) { // 맞춘 알파벳 오픈
                guessedWord += "\(letter)"
            } else { // 나머지 알파벳 _ 처리
                guessedWord += "_"
            }
        }
        
        return guessedWord
    }
    
    // 플레이어가 선택한 알파벳이 단어에 속해있는지 확인
    mutating func playerGuessed(letter: Character) -> Bool {
        guessedLetters.append(letter)
        
        // 속해있지 않을 경우 기회 1 감소
        if !word.contains(letter) {
            incorrectMovesRemaining -= 1
            return false
        }
        
        return true
    }
}
