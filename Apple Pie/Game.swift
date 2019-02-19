//
//  Game.swift
//  Apple Pie
//
//  Created by Getu Gebre on 2/14/19.
//  Copyright © 2019 Getu Gebre. All rights reserved.
//

import Foundation

struct Game {
    //var playerName : String
    var word : String
    var incorrectMovesRemaining : Int
    var guessedLetters : [Character]
    var correctGuesses0: Int
    var correctGuesses1: Int
    var players = 0 {
        didSet {
            
        }
    }
//    static var currentPlayer : Game = Game(playerName : "", word: "", incorrectMovesRemaining: 0, guessedLetters: [], correctGuesses: 0, players: [])
//    
//    static func newPlayer (newplayer : Game){
//            currentPlayer = newplayer
//    }
    mutating func playerGuessed(letter: Character){
        guessedLetters.append(letter)
        if !word.contains(letter){
            incorrectMovesRemaining -= 1
            if players == 0{
                players = 1
            } else {
                players = 0
            }
        } else {
            if players == 0{
                correctGuesses0 += 1
            } else {
                correctGuesses1 += 1
            }
            
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
