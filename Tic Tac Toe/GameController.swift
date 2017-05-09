//
//  ViewController.swift
//  Tic Tac Toe
//
//  Created by kayla dozier on 5/3/17.
//  Copyright © 2017 kayla dozier. All rights reserved.
//

import UIKit
import GameplayKit

class GameController: UIViewController {
    
    //Created variable to save player order once game is initiated.
    var selectedPlayer : Int!
    var currentPlayer = 1
    var gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    
    
    
    let winningCombinations = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
    var activeGame = true
    
    /// Disables all the fields after Tic Tac Toe
    func gameOver() {
        for i in 1...9
        {
            view.viewWithTag(i)?.isUserInteractionEnabled = false
        }
        
        
    }
    //Player object created to show order in which turns are taken.
    @IBAction func gameOption(_ sender: UIButton) {
        if (gameState[sender.tag - 1] == 0) {
            
            gameState[sender.tag - 1] = currentPlayer
            
            if (currentPlayer == 1) {
                
                (sender as AnyObject).setImage(UIImage(named: "X"), for: UIControlState())
                currentPlayer = 2
                
            } else {
                
                (sender as AnyObject).setImage(UIImage(named: "O"), for: UIControlState())
                currentPlayer = 1
            }
            
        }
        
        
        
        //For loop created for possible game combinations. Simple conditional statements to handle state of game and hide reset game options while game is active
        for possibility in winningCombinations {
            
            if gameState[possibility[0]] != 0 && gameState[possibility[0]] == gameState[possibility[1]] && gameState[possibility[1]] == gameState[possibility[2]] {
                
                activeGame = false
                
                if gameState[possibility[0]] == 1 {
                    
                }   else {
                    
                    print("")
                    
                }

                resetGame.isHidden = false
                gameOver()
                
                
            }
            
            activeGame = false
            
            for i in gameState {
                
                if i == 0 {
                    
                    activeGame = true
                    break
                }
            }
            if activeGame == false {
                
                resetGame.isHidden = false
                gameOver()
                
            }
            
        }
        
    }
    
    //Feedback that game is over, whether it's a draw or there is a winner. AI hasn't been set to win yet.
    //There is a bug. The reset game button should only appear when a player has won or the game is a draw. Initially the reset game button does appear when the game is started, but disappears once the first move is made. This only happens while playing the game for the first time.
    @IBAction func resetGame(_ sender: UIButton) {
        gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        activeGame = true
        currentPlayer = selectedPlayer
        
        resetGame.isHidden = true
        
        
        for i in 1...9
        {
            let button = view.viewWithTag(i) as! UIButton
            button.setImage(nil, for: UIControlState())
            button.isUserInteractionEnabled = true
        }
        
        
        
    }
    
    @IBOutlet weak var resetGame: UIButton!
    
    
    
}

