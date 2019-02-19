//
//  ViewController.swift
//  Apple Pie
//
//  Created by Getu Gebre on 2/14/19.
//  Copyright © 2019 Getu Gebre. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var listOfWords = ["dorowot", "noodles", "soccer", "reading", "dog", "cat", "television","dresser", "plates"]
    let incorrectMovesAllowed = 7
    
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    var totalLoses = 0 {
        didSet {
            newRound()
        }
    }
    var correctGuess = 0 {
        didSet {
            
        }
    }
    var correctGuessupdate = 0 {
        didSet {
            newRound()
    }
}
    var players : [Int] = [1, 2]
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var treeImageView: UIImageView!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    @IBOutlet var letterButtons: [UIButton]!
    @IBAction func buttonTapped(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        print(currentGame.players)
        if currentGame.players == 0 {
            correctGuess = currentGame.correctGuesses0
        } else {
            correctGuess = currentGame.correctGuesses1
        }
        
        print(correctGuess)
        updateGameState()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        newRound()
        
    }
    func updateGameState(){
        if currentGame.incorrectMovesRemaining == 0{
            totalLoses += 1
            
        }else if currentGame.word == currentGame.formattedWord {
            totalWins += 1
            correctGuessupdate += 5
        } else {
            updateUI()
        }
    }
    var currentGame : Game!
    func newRound (){
        if !listOfWords.isEmpty {
            let randInt = Int.random(in: 0..<listOfWords.count)
            //let newWord = listOfWords.removeFirst()
            let newWord = listOfWords.remove(at: randInt)
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters : [], correctGuesses0: correctGuess,correctGuesses1: correctGuess, players: 0)
            enableLetterButtons(true)
            updateUI()
        } else {
            enableLetterButtons(false)
        }
       
    }
    func updateUI(){
        var letters = [String]()
//        for letter in currentGame.formattedWord {
//            letters.append(String(letter))
//        }
        letters = currentGame.formattedWord.map({String($0)})
        
        let wordWithSpacing = letters.joined(separator: " ")
        correctWordLabel.text = wordWithSpacing
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLoses), score:\(correctGuess + correctGuessupdate), player:\(currentGame.players)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }
    func enableLetterButtons (_ enable: Bool){
        for button in letterButtons {
            button.isEnabled = enable
        }
    }


}

