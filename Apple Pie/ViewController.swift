//
//  ViewController.swift
//  Apple Pie
//
//  Created by Getu Gebre on 2/14/19.
//  Copyright © 2019 Getu Gebre. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var listOfWords = ["basketball", "handball", "soccer", "football", "hockey", "baseball", "athletics"]
    let incorrectMovesAllowed = 7
    
    var totalWins = [0,0] {
        didSet {
            newRound()
        }
    }
    var totalLoses = [0,0] {
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
    
    @IBOutlet weak var completeWordOutlet: UIView!
    @IBOutlet weak var letterButtonsOutlet: UIStackView!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var scoreLabel2: UILabel!
    
    
    @IBOutlet weak var activePlayer: UILabel!
    
    @IBAction func completeWordTapped(_ sender: UIButton) {
        letterButtonsOutlet.isHidden = true
        completeWordOutlet.isHidden = false
    }
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
        completeWordOutlet.isHidden = true
        self.hideKeyboardWhenTappedAround()
    }
    func updateGameState(){
        if currentGame.incorrectMovesRemaining == 0{
            //totalLoses += 1
            
            totalLoses[0] = multipleUserHandler(input1: totalLoses[0], input2: totalLoses[1], input3: playerSwitch).0
            totalLoses[1] = multipleUserHandler(input1: totalLoses[0], input2: totalLoses[1], input3: playerSwitch).1
            
        }else if currentGame.word == currentGame.formattedWord {
            
            totalWins[0] = multipleUserHandler(input1: totalWins[0], input2: totalWins[1], input3: playerSwitch).0
            totalWins[1] = multipleUserHandler(input1: totalWins[0], input2: totalWins[1], input3: playerSwitch).1
            
            
        } else {
            updateUI()
        }
    }
    var currentGame : Game!
    func newRound (){
        if !listOfWords.isEmpty {
            let randInt = Int.random(in: 0..<listOfWords.count)
            
            let newWord = listOfWords[randInt]
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters : [], correctGuesses0: correctGuess0,correctGuesses1: correctGuess1, players: playerSwitch)
            enableLetterButtons(true)
            updateUI()
        } else {
            enableLetterButtons(false)
        }
        
    }
    func updateUI(){
        var letters = [String]()
        
        letters = currentGame.formattedWord.map({String($0)})
        
        let wordWithSpacing = letters.joined(separator: " ")
        correctWordLabel.text = wordWithSpacing
        scoreLabel.text = "Wins: \(totalWins[0]),  Losses: \(totalLoses[0]),  player 1 score:\(correctGuess0)"
        scoreLabel2.text = "Wins: \(totalWins[1]),  Losses: \(totalLoses[1]),   player 2 score:\(correctGuess1)   "
        activePlayer.text = "Player\(currentGame.players + 1)'s turn."
        
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }
    func enableLetterButtons (_ enable: Bool){
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
    
    func multipleUserHandler (input1: Int, input2: Int, input3: Int)->(Int, Int){
        var newVar = (input1, input2)
        
        if input3 == 0{
            newVar.0 += 1
        }else{
            newVar.1 += 1
        }
        return newVar
    }
}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
