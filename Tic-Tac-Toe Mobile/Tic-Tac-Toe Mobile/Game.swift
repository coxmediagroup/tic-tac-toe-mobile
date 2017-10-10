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


enum GameStates: Int {
   case playing = 0
   case playerWon = 1
   case siriWon = 2
   case draw = 3
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

   func newGame(playerIs: PlayerLetter) {
      // Set the player's letter based on their choosing
      players[0].playerLetter = playerIs
      // Siri is the other letter
      players[1].playerLetter = PlayerLetter.oppositeOf(value: playerIs)
      board.clearBoard()
      turn = .player
      gameState = .playing
   }
   
   
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
      for index in 0...8 {
         if turn == .siri {
            if board.spaceIsUnused(index: index) {
               if let boardState = BoardStates.boardStateForString(stringValue: players[1].playerLetter.rawValue) {
                  board.setBoardState(index: index, state: boardState)
                  checkNextMove()
               }
            }
         }
      }
   }

   func checkNextMove() {
      if board.isGameOver() {  // if the game is over, see who won, if any
         if let winner = board.gameWinner() {
            if winner == players[0].playerLetter.rawValue {
               gameState = .playerWon
            } else {
               gameState = .siriWon
            }
         } else {
            gameState = .draw
         }
      } else {  // otherwise, switch turns
         if turn == .player {
            turn = .siri
            siriMakeMove()
         } else {
            turn = .player
         }
      }
   }
}
