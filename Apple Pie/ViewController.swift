//
//  ViewController.swift
//  Apple Pie
//
//  Created by Park JooHyun on 2022/04/11.
//

import UIKit

class ViewController: UIViewController {

    var listOfWords = ["buccaneer", "swift", "glorious", "incandescent", "bug", "program"] // 게임 단어 목록
    let incorrectMovesAllowed = 7 // 남은 기회
    var totalWins = 0 { // 맞춘 단어 수
        didSet {
            newRound()
        }
    }
    var totalLosses = 0 { // 틀린 단어 수
        didSet {
            newRound()
        }
    }
    var totalScores = [0, 0] // 플레이어 별 점수
    var currentGame: Game!
    var currPlayer = 0 // 현재 차례 플레이어
    
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
        // 현재 단어
        let letters = currentGame.formattedWord.map { String($0) }
        let wordWithSpacing = letters.joined(separator: " ")
        correctWordLabel.text = wordWithSpacing
        
        // 맞춘 단어, 틀린 단어 수
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        
        // 사과나무 이미지
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
                
        // 플레이어
        for (i, player) in players.enumerated() {
            player.text = "Score: \(totalScores[i])"
            player.backgroundColor = .clear
        }
        
        players[currPlayer].backgroundColor = .yellow
    }
    
    // 새로운 라운드 세팅
    func newRound() {
        if !listOfWords.isEmpty {
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
            enableLetterButtons(true)
        } else { // 게임 종료
            enableLetterButtons(false)
        }
        updateUI()
    }
    
    // 플레이어가 알파벳 버튼을 눌렀을 경우
    @IBAction func letterButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.configuration!.title!
        let letter = Character(letterString.lowercased())
        
        if currentGame.playerGuessed(letter: letter) { // 올바른 알파벳을 선택한 경우 점수 상승
            totalScores[currPlayer] += 1
        } else { // 틀렸을 경우 플레이어 차례 변경
            turnPlayer()
        }
        
        updateGameState()
    }
    
    // 전체 알파벳 버튼 활성화 or 비활성화
    func enableLetterButtons(_ enable: Bool) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
    
    // 현재 라운드 상태 파악
    func updateGameState() {
        if currentGame.incorrectMovesRemaining == 0 { // 남은 기회가 없을 경우 다음 라운드 진행
            totalLosses += 1
        } else if currentGame.word == currentGame.formattedWord { // 단어를 맞췄을 경우 맞춘 플레이어 점수 상승, 다음 라운드 진행
            totalScores[currPlayer] += currentGame.incorrectMovesRemaining
            totalWins += 1
        } else { // 현재 라운드 계속 진행
            updateUI()
        }
    }
    
    // 플레이어 차례 변경
    func turnPlayer() {
        currPlayer += 1
        
        if currPlayer >= totalScores.count {
            currPlayer = 0
        }
    }
}

