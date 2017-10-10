//
//  Player.swift
//  Tic-Tac-Toe Mobile
//
//  Identifies a player and their attributes

//  Created by Dave Haupert on 10/10/17.
//  Copyright © 2017 DDH Software. All rights reserved.
//

import Foundation


enum PlayerType : String {
   case player = "Player"
   case siri = "Siri"
   

}

enum PlayerLetter : String {
   case x = "X"
   case o = "O"
   static func oppositeOf(value: PlayerLetter) -> PlayerLetter {
      if value == .x {
         return .o
      }
      return .x
   }

}

class Player {

   var playerType: PlayerType!
   
   var playerLetter: PlayerLetter!

   init(type: PlayerType, letter: PlayerLetter) {
      playerType = type
      playerLetter = letter
   }
   
   

}
