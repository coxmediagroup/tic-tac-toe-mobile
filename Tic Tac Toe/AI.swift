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
    
    //This is the file where all AI implementation is handled. Initially a start with satisfying all required functions and protocols and each of the variables. Set up Didn't have much time to go further with this part, but there's plenty of potential code. Ran into a hangup when trying to have the AI class conform to NSObject, GKGameModel, GKGameModelPlayer, and GKGameModelUpdate. My thoughts were to then remove the protocols and created extensions. Instead creating classes to separate the model logic to house data required to function and actually implement movement logic in the Move class. In the future, will work on GKGameModel implement and having the AI class conform to that protocol. Should make the code a bit cleaner and concise.
    
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
    
    
    //  This class handles any possible move projections.
    class Move: NSObject, GKGameModelUpdate {
        
        var value: Int = 0
        
    }
    
    
    //    extension AI: GKGameModel {
    //
    //    }
    
    ////    extension AI: GKGameModelUpdate {
    ////        
    ////    }
    
    

}
