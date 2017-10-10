//
//  Game.swift
//  Tic-Tac-Toe Mobile
//
//  Tracks the status of a game, all players and the game board itself
//
//  Created by Dave Haupert on 10/10/17.
//  Copyright © 2017 DDH Software. All rights reserved.
//

import Foundation


enum GameStates: String {
   case playing = "Playing"
   case playerWon = "You Won!"
   case siriWon = "Siri Won"
   case draw = "It's a draw"
}


protocol GameEventsDelegate: class {
   func siriPlayedMove(_ index: Int)
   func gameOver(_ winner: String)
}

class Game {
   
   
   var players: [Player] = [
      Player(type: .player, letter: .x),
      Player(type: .siri, letter: .o),
      ]

   // who's turn is next
   var turn: PlayerType = .player

   var gameState: GameStates = .draw
   
   // The game board object
   var board: GameBoard = GameBoard()

   weak var delegate: GameEventsDelegate?
   
   
   
   func newGame(playerIs: PlayerLetter) {
      // Set the player's letter based on their choosing
      players[0].playerLetter = playerIs
      // Siri is the other letter
      players[1].playerLetter = PlayerLetter.oppositeOf(value: playerIs)
      board.clearBoard()
      turn = .player
      gameState = .playing
   }
   
   // Returns true if the player is allowed to make a move
   func canPlayerMove() -> Bool {
      if gameState == .playing {  // only if playing
         // only if it's their turn
         if turn == .player {
            // only if the game is still on
            if board.isGameOver() == false {
               return true
            }
         }
      }
      return false
   }

   //    Dumb AI for testing Siri losing
   func playerMakeMove(index: Int) -> Bool {
      if canPlayerMove() {
         if board.spaceIsUnused(index: index) {
            if let boardState = BoardStates.boardStateForString(stringValue: players[0].playerLetter.rawValue) {
               board.setBoardState(index: index, state: boardState)
               checkNextMove()
               return true
            }
         }
      }
      return false
   }

   
   func siriMakeMove() {
      if turn == .siri {
         miniMaxCalculatedMove()
         // dumbAICalculatedMove()
      }
   }

   func dumbAICalculatedMove() {
      for index in 0...8 {
         if turn == .siri {
            if board.spaceIsUnused(index: index) {
               if let boardState = BoardStates.boardStateForString(stringValue: players[1].playerLetter.rawValue) {
                  board.setBoardState(index: index, state: boardState)
                  // Notify the delegate that Siri has played his/her move!
                  delegate?.siriPlayedMove(index)
                  checkNextMove()
               }
            }
         }
      }
   }
   
   func checkNextMove() {
      if board.isGameOver() {  // if the game is over, see who won, if any
         turn = .player  // make sure siri doesn't keep playing moves
         if let winner = board.gameWinner() {
            if winner == players[0].playerLetter.rawValue {
               gameState = .playerWon
            } else {
               gameState = .siriWon
            }
         } else {
            gameState = .draw
         }
         delegate?.gameOver(gameState.rawValue)
      } else {  // otherwise, switch turns
         if turn == .player {
            turn = .siri
            siriMakeMove()
         } else {
            turn = .player
         }
      }
   }
   
   
   
   // MARK : Minimax AI functionality
   
   func miniMaxCalculatedMove() {
      
      DispatchQueue.global(qos: .userInitiated).async { // Start asynchronously so that the UI is not blocked by this long operation
         
         let result = self.miniMaxCalculation(board: self.board, playerLetter: self.players[1].playerLetter)
         
         DispatchQueue.main.async {
            if let boardState = BoardStates.boardStateForString(stringValue: self.players[1].playerLetter.rawValue) {
               self.board.setBoardState(index: result.bestChoice, state: boardState)
               // Notify the delegate that Siri has played his/her move!
               self.delegate?.siriPlayedMove(result.bestChoice)
               self.checkNextMove()
            }
         }
      }

   }
   
   // Returns a tuple, with the estimated score for the move on the board, and the best choice given the scores so far
   func miniMaxCalculation(board: GameBoard, playerLetter: PlayerLetter) -> (score: Int, bestChoice: Int) {

      
      // are there any more movements left?
      if board.isGameOver() {
         return (score: calculateScore(board), bestChoice: -1)
      }
      
      var scores : [Int] = []  // tracks the scores of each move on the board
      var moves : [Int] = []   // tracks the move that goes with the score.
      
      let movesLeft = board.getMovesLeft()
      for move in movesLeft
      {
         let nextBoard = board.copyGameBoard()
         
         if let boardState = BoardStates.boardStateForString(stringValue: playerLetter.rawValue) {
            nextBoard.setBoardState(index: move, state: boardState)

            // Score out the next move by recursion
            let miniMaxCalculated = miniMaxCalculation(board: nextBoard, playerLetter : PlayerLetter.oppositeOf(value: playerLetter))
            // save the score for this calculation
            scores.append(miniMaxCalculated.score)
            // save the move that goes with the score
            moves.append(move)
         }
      }
      // for Siri choose maximum from moves
      if players[1].playerLetter == playerLetter {
         let index = indexOfMaximum(list: scores)
         let choice = moves[index]
         return (scores[index], choice)
      }
      else // for player the minimum is better for the calculation
      {
         let index = indexOfMinimum(list: scores)
         let choice = moves[index]
         return (scores[index], choice)
      }
   }
   
   
   func calculateScore(_ board: GameBoard) -> Int {
      
      let winner = board.gameWinner()
      if winner == nil {
         return 0
      } else if winner == players[1].playerLetter.rawValue {
         return 10
      } else {
         return -10
      }
   }
   
   
   func indexOfMinimum(list: [Int]) -> Int {
      var result = 0
      var min = list[0]
      for index in 1..<list.count {
         if list[index] < min {
            result = index;
            min = list[index]
         }
      }
      return result;
   }
   
   func indexOfMaximum(list: [Int]) -> Int {
      var result = 0
      var max = list[0]
      for index in 1..<list.count {
         if list[index] > max {
            result = index;
            max = list[index]
         }
      }
      return result;
   }


}
