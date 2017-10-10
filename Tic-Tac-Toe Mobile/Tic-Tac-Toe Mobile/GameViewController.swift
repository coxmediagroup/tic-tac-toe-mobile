//
//  GameViewController.swift
//  Tic-Tac-Toe Mobile
//
//  Created by Dave Haupert on 10/10/17.
//  Copyright © 2017 DDH Software. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

   @IBOutlet weak var status: UILabel!

   @IBOutlet weak var playerScore: UILabel!
   @IBOutlet weak var siriScore: UILabel!

   @IBOutlet weak var button0: UIButton!
   @IBOutlet weak var button1: UIButton!
   @IBOutlet weak var button2: UIButton!
   
   @IBOutlet weak var button3: UIButton!
   @IBOutlet weak var button4: UIButton!
   @IBOutlet weak var button5: UIButton!
   
   @IBOutlet weak var button6: UIButton!
   @IBOutlet weak var button7: UIButton!
   @IBOutlet weak var button8: UIButton!
   
   
   var currentLetter: PlayerLetter = .x
   
   var game: Game = Game()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view, typically from a nib.
   }

   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }

   @IBAction func boardButtonPressed(_ sender: UIButton) {
      if game.canPlayerMove() {
         if game.playerMakeMove(index: sender.tag) {
            sender.setTitle(currentLetter.rawValue, for: .normal)
            updateStatus(text: "Siri's turn...")
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
      game.newGame(playerIs: self.currentLetter)
      updateStatus(text: "Make your Move!")
   }
   
   func updateStatus(text: String) {
      status.text = text
   }

}

