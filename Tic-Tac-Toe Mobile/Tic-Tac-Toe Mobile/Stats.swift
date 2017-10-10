//
//  Stats.swift
//  Tic-Tac-Toe Mobile
// 
//  Save and Load game win statistics
//
//  Created by Dave Haupert on 10/10/17.
//  Copyright © 2017 DDH Software. All rights reserved.
//

import Foundation


class Stats {
   
   static let PLAYER_WIN_COUNT_DEFAULTS = "Player Wins"
   static let SIRI_WIN_COUNT_DEFAULTS = "Siri Wins"

   var playerWinCount = 0
   var siriWinCount = 0
   
   init() {
      loadHistory()
   }
   
   // Load the last set of stats, in case app was killed or device was reset
   func loadHistory() {
      if let playerWins = UserDefaults.standard.value(forKey: Stats.PLAYER_WIN_COUNT_DEFAULTS) as? Int {
         playerWinCount = playerWins
      }
      if let siriWins = UserDefaults.standard.value(forKey: Stats.SIRI_WIN_COUNT_DEFAULTS) as?  Int {
         siriWinCount = siriWins
      }
   }
   
   func siriWon() {
      siriWinCount += 1
      saveHistory()
   }

   func playerWon() {
      playerWinCount += 1
      saveHistory()
   }
   
   // Save the last set of stats, in case app gets killed or device gets reset
   func saveHistory() {
      UserDefaults.standard.set(playerWinCount, forKey: Stats.PLAYER_WIN_COUNT_DEFAULTS)
      UserDefaults.standard.set(siriWinCount, forKey: Stats.SIRI_WIN_COUNT_DEFAULTS)
   }
}
