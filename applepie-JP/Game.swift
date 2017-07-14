//
//  Game.swift
//  applepie-JP
//
//  Created by MEI KU on 2017/7/13.
//  Copyright © 2017年 Natalie KU. All rights reserved.
//

import Foundation

struct Game {
    var word: String
    var incorrectMovesRemaining:Int
    var guessedLetters:[Character]
    
    mutating func playerGuessed (letter:Character) {
        guessedLetters.append(letter)
        if !word.characters.contains(letter) {
            incorrectMovesRemaining -= 1
        }
    }
    
    var formattedWord: String  {
        var guessedWord = ""
        for letter in word.characters {
            if guessedLetters.contains(letter)  {
                guessedWord += "\(letter)"
            }
            else {
                guessedWord += "_"
            }
        }
        return guessedWord
    }
}
   


