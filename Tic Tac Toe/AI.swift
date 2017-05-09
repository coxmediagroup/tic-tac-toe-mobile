//
//  AI.swift
//  Tic Tac Toe
//
//  Created by kayla dozier on 5/7/17.
//  Copyright © 2017 kayla dozier. All rights reserved.
//

import Foundation
import GameplayKit

class AI: NSObject, GKGameModelPlayer {
    
//This is the file where all AI implementation is handled. Initially a start with satisfying all required functions and protocols and each of the variables. Set up Didn't have much time to go further with this part, but there's plenty of potential code. Ran into a hangup when trying to have the AI class conform to NSObject, GKGameModel, GKGameModelPlayer, and GKGameModelUpdate. My thoughts were to then remove the protocols and created extensions. Instead creating classes for the In the future, I'd separate the protocol logic from the AI class and simply implement the computer wins and player goes first logic. Should make the code a bit cleaner and concise.
    
    var playerId: Int

    var activePlayer: GKGameModelPlayer?
    
    var players: [GKGameModelPlayer]?
    
    var strategist = GKMinmaxStrategist()
    
    
    
    func apply(_ gameModelUpdate: GKGameModelUpdate) {
        
    }
    
    func gameModelUpdates(for player: GKGameModelPlayer) -> [GKGameModelUpdate]? {
        return nil
    }
    
    func setGameModel(_ gameModel: GKGameModel) {
        
    }

    
//    Property configuration for gameplay behavior.
    override init() {
        super.init(playerId = 1)
        
        playerId = 1
        strategist.maxLookAheadDepth = 3
        strategist.randomSource = nil

    
    }



    class Move: NSObject, GKGameModelUpdate {
        
        var value: Int = 0
        
    }


//    extension AI: GKGameModel {
//        
//    }
////
////    extension AI: GKGameModelUpdate {
////        
////    }



}
