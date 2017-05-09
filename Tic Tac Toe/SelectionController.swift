//
//  SelectionController.swift
//  Tic Tac Toe
//
//  Created by kayla dozier on 5/8/17.
//  Copyright © 2017 kayla dozier. All rights reserved.
//

import UIKit

class SelectionController: UIViewController {
    
    //Instance variable created.
    var selectedX = true
    
    //Didn't do much with the UILabel yet.
    @IBOutlet weak var selectionLabel: UILabel!
    
    //Simple boolean to determine whether X or O is selected.
    @IBAction func xButton(_ sender: UIButton) {
        
        selectedX = true
        
    }
    
    @IBAction func oButton(_ sender: UIButton) {
        
        selectedX = false
    }
    
    //Conditional statement that instantiates which players goes first and retains memory once game is initiated.
    @IBAction func startGame(_ sender: Any) {
        
    }
    
    //Destination segue created to save player order choice upon start of game.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let next = segue.destination as? GameController {
            
            if selectedX {
                
                next.currentPlayer = 1
                next.selectedPlayer = 1
                
            } else {
                
                next.currentPlayer = 2
                next.selectedPlayer = 2
                
                
                
            }
            
        }
        
    }
    
    
}
