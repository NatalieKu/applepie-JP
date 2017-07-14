//
//  ViewController.swift
//  applepie-JP
//
//  Created by MEI KU on 2017/7/13.
//  Copyright © 2017年 Natalie KU. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var treeImageView: UIImageView!
    
    
    @IBOutlet weak var correctWordLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet var letterButtons: [UIButton]!
    
 var currentGame : Game!
    var listOfWords = ["ともなう", "なさけない", "うちあける", "うつわ","みたらい"]
    var incorrectMovesAllowed = 7
    
    var totalWins = 0  {
      didSet {
        newRound()
    }
        
    }
    var totalLosses = 0  {
        didSet {
            
     newRound()
            
                
}
    }
        
    var numberToCount = 0
    var myTimer:Timer?
    var totalTime = "00:00"
    
    
    
    
    
    
    @IBAction  func buttonTapped(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
    currentGame.playerGuessed(letter:letter)
        updateGameState()
        
    }
    
    
    
    func updateGameState() {
        if currentGame.incorrectMovesRemaining == 0 {
            
            totalLosses += 1
            let speechUtterance =  AVSpeechUtterance(string: "オシイイ")
            speechUtterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
            let synth = AVSpeechSynthesizer()
            synth.speak(speechUtterance)
            
        }
        else if currentGame.word == currentGame.formattedWord {
            
            totalWins += 1
            let speechUtterance =  AVSpeechUtterance(string: "スゴイイ")
            speechUtterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
            let synth = AVSpeechSynthesizer()
            synth.speak(speechUtterance)
            
        }
        else {
            updateUI ()
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.timerSet), userInfo: nil, repeats: true)
        
        newRound()
     
    }
    
    
    
    
    func newRound() {
        if  !listOfWords.isEmpty {
            
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
            enableLetterButtons(_enable: true)
            
            updateUI()
            
            
        }
        else {
            enableLetterButtons(_enable: false)
            if  listOfWords.isEmpty == true {
                
                listOfWords = ["ともなう", "なさけない", "うちあける", "うつわ","みたらい"]
                listOfWords.insert("ともなう", at:0)
                initialize()
                
                
            }
                
            }
        
    }
    
        
        
    
    
   
    
    
    func updateUI() {
        var letters = [String]()
        for letter in currentGame.formattedWord.characters {
            letters.append(String(letter))
        }
        let wordWithSpacing = letters.joined (separator:" ")
        correctWordLabel.text = wordWithSpacing
        scoreLabel.text = "正解: \(totalWins),誤答: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
        
    }
    
    
    @objc func timerSet() {
        
     numberToCount += 1
        let mins =  numberToCount/60
        let seconds = numberToCount % 60
        self.timerLabel.text = " 時間経過 \(String(format:"%.2d", mins)):\(String(format:"%.2d", seconds))"    }
    
    
    
    func enableLetterButtons(_enable: Bool)  {
        
        for button in letterButtons  {
            button.isEnabled = true
            
    }
    }
    func initialize ()  {
        totalWins = 0
        totalLosses = 0
        numberToCount = 0
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
            
        
        // Dispose of any resources that can be recreated.
    }


}

