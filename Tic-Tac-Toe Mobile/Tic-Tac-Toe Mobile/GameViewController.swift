//
//  GameViewController.swift
//  Tic-Tac-Toe Mobile
//
//  Created by Dave Haupert on 10/10/17.
//  Copyright © 2017 DDH Software. All rights reserved.
//

import UIKit
import AVFoundation

class GameViewController: UIViewController, GameEventsDelegate {

   @IBOutlet weak var status: UILabel!

   @IBOutlet weak var playerScore: UILabel!
   @IBOutlet weak var siriScore: UILabel!

   var currentLetter: PlayerLetter = .x
   
   var game: Game = Game()
   var stats: Stats = Stats()
   
   let taunts: [String] = ["Bring your best.  You cannot beat me!",
                           "You can try, but you will not succeed",
                           "You are wasting your time.  I'm unstoppable",
                           "I have mastered this game already, you have zero chance",]
   

   
   override func viewDidLoad() {
      super.viewDidLoad()
      // sign up for receiving game event updates
      game.delegate = self
      updateStats()
   }

   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }

   // Called when any of the buttons in the grid are pressed
   @IBAction func boardButtonPressed(_ sender: UIButton) {
      if game.canPlayerMove() {
         if game.playerMakeMove(index: sender.tag) {
            sender.setTitle(currentLetter.rawValue, for: .normal)
            updateStatus(text: "Siri is thinking...")
         } else {
            updateStatus(text: "Spot already taken.  Choose another.")
         }
      }
   }
   
   @IBAction func newGamePressed(_ sender: UIBarButtonItem) {
      
      // See what letter the player wants to be
      let alertController = UIAlertController(title: "New Game", message: "Choose Your Letter", preferredStyle: UIAlertControllerStyle.actionSheet)
      let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (result : UIAlertAction) -> Void in
      }
      let xAction = UIAlertAction(title: "X", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
         self.currentLetter = .x
         self.newGame()
      }
      let oAction = UIAlertAction(title: "O", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
         self.currentLetter = .o
         self.newGame()
      }
      alertController.addAction(xAction)
      alertController.addAction(oAction)
      alertController.addAction(cancelAction)
      self.present(alertController, animated: true, completion: nil)
   }

   func newGame() {
      // A little taunting to raise the stakes!
      speakPhrase(phrase: getRandomTaunt())
      

      game.newGame(playerIs: self.currentLetter)
      // Clear the board
      for index in 0...8 {
         if let button = self.view.viewWithTag(index) as? UIButton {
            button.setTitle("", for: .normal)
         }
      }
      updateStatus(text: "Make your Move!")
   }
   
   
   func updateStatus(text: String) {
      status.text = text
   }
   
   // MARK: GameEventsDelegate functions
   
   func gameOver(_ winner: String) {
      updateStatus(text: "Results: " + winner)
      if winner.contains(GameStates.siriWon.rawValue) {
         speakPhrase(phrase: "Ha Ha, I beat you!")
         stats.siriWon()
         
      } else if winner.contains(GameStates.playerWon.rawValue) {
         speakPhrase(phrase: "I'll get you next time!")
         stats.playerWon()
      } else {
         speakPhrase(phrase: "We seem to be equally matched.")
      }
      updateStats()
   }
   
   
   func siriPlayedMove(_ index: Int) {
      if let button = self.view.viewWithTag(index) as? UIButton {
         button.setTitle(PlayerLetter.oppositeOf(value: self.currentLetter).rawValue, for: .normal)
      }
      updateStatus(text: "Your turn!")


   }

   
   // MARK: Not part of acceptance criteria but to make the game more fun
   
   func speakPhrase(phrase: String) {
      let utterance = AVSpeechUtterance(string: phrase)
      utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
      
      let synthesizer = AVSpeechSynthesizer()
      synthesizer.speak(utterance)
   }

   func getRandomTaunt() -> String {
     let index: Int = Int(arc4random_uniform(UInt32(taunts.count)))
     return(taunts[index])
   }
   
   // MARK: Stats functionality
   func updateStats() {
      siriScore.text = "\(stats.siriWinCount)"
      playerScore.text = "\(stats.playerWinCount)"
   }
   
   

}

