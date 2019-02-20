//
//  ViewController.swift
//  Apple Pie
//
//  Created by Getu Gebre on 2/14/19.
//  Copyright © 2019 Getu Gebre. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var listOfWords = ["basketball", "noodles", "soccer", "reading", "elephant", "coding", "computer","dresser", "plates"]
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
    //correct guess by player 1
    var correctGuess0 = 0
    //correct guess by player 2
    var correctGuess1 = 0 
    
    var correctGuessupdate = 0 {
        didSet {
            newRound()
    }
}
    var playerSwitch : Int = 0
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var treeImageView: UIImageView!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    @IBOutlet var letterButtons: [UIButton]!
    @IBAction func buttonTapped(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        
        playerSwitch = currentGame.players
        if playerSwitch == 0 {
            correctGuess0 = currentGame.correctGuesses0
        } else {
            correctGuess1 = currentGame.correctGuesses1
        }
        
        
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
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters : [], correctGuesses0: correctGuess0,correctGuesses1: correctGuess1, players: playerSwitch)
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
        scoreLabel.text = "Wins: \(totalWins),  Losses: \(totalLoses),  player 1 score:\(correctGuess0),    player 2 score:\(correctGuess1),     player:\(currentGame.players)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }
    func enableLetterButtons (_ enable: Bool){
        for button in letterButtons {
            button.isEnabled = enable
        }
    }


}

