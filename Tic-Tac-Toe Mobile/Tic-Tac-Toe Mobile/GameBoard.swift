//
//  GameBoard.swift
//  Tic-Tac-Toe Mobile
//
//  Make-up of the board used in the game

//  Created by Dave Haupert on 10/10/17.
//  Copyright © 2017 DDH Software. All rights reserved.
//

import Foundation

enum BoardStates : String {
   case x = "X"
   case o =   "O"
   case unused =  "Unused"
   
   static func boardStateForString(stringValue: String) -> BoardStates? {
      if stringValue == BoardStates.x.rawValue {
         return BoardStates.x
      }
      if stringValue == BoardStates.o.rawValue {
         
         return BoardStates.o
      }
      if stringValue == BoardStates.unused.rawValue {
         return BoardStates.unused
      }
      return nil
   }

}

class GameBoard {
   
   var board: [BoardStates] = [ BoardStates.unused,
                                BoardStates.unused,
                                BoardStates.unused,
                                
                                BoardStates.unused,
                                BoardStates.unused,
                                BoardStates.unused,
                                
                                BoardStates.unused,
                                BoardStates.unused,
                                BoardStates.unused,
                                ]

   // patterns of possible ways to win
   let winningPatterns = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8],
                          [0, 4, 8], [2, 4, 6]]

   

   // Set the state of a spot on the grid
   func setBoardState( index: Int, state: BoardStates) {
      board[index] = state
   }

   // Returns true if the space passed by index is not yet played
   func spaceIsUnused(index: Int ) -> Bool {
      if board[index] == .unused {
         return true
      }
      return false
   }

   // Reset the state of the entire board
   func clearBoard() {
      for index in 0...8  {
         setBoardState(index: index, state: BoardStates.unused)
      }
   }
   
   // Create a copy of the current board, for recursion in minimax functions
   func copyGameBoard() -> GameBoard {
      let newBoard = GameBoard()
      newBoard.board = board
      return newBoard
   }

   
   // Returns true if someone has won or there are no spaces left on the board
   func isGameOver() -> Bool {
      // is the game won already?
      if let _ = gameWinner() {
         return true
      }
      // otherwise, are there any spaces left on the board
      if (board.filter{$0 == .unused }.count == 0) {
         return true
      }
      return false
      
   }
   
   // Returns a list of the remaining moves on the board
   func getMovesLeft() -> [Int] {
      
      var moves:[Int] = []
      for index in 0...8 {
         if board[index] == .unused {
            moves.append(index)
         }
      }
      
      return moves;
   }

   
   // Returns the winning letter of the game, if any, otherwise, nil
   func gameWinner() -> String? {
      for pattern in winningPatterns {
         if (board[pattern[0]] == board[pattern[1]]) && (board[pattern[1]] == board[pattern[2]]) && board[pattern[0]] != .unused {
            return board[pattern[0]].rawValue
         }
      }
      return nil
   }
   
   
}
