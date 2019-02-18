//
//  Game.swift
//  Apple Pie
//
//  Created by Getu Gebre on 2/14/19.
//  Copyright © 2019 Getu Gebre. All rights reserved.
//

import Foundation

struct Game {
    var word : String
    var incorrectMovesRemaining : Int
    var guessedLetters : [Character]
    var correctGuesses: Int
    
    mutating func playerGuessed(letter: Character){
        guessedLetters.append(letter)
        if !word.contains(letter){
            incorrectMovesRemaining -= 1
            
        } else {
            correctGuesses += 1
        }
    }
    var formattedWord : String {
        var guessedWord = ""
        for letter in word {
            if guessedLetters.contains(letter){
                guessedWord += "\(letter)"
                
            } else {
                guessedWord += "_"
            }
        }
        return guessedWord
    }
}
