//
//  ViewController.swift
//  Tic_Tac_Toe
//
//  Created by Kelly Robinson on 5/4/17.
//  Copyright © 2017 Kelly Robinson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var player = 0
    var playerIsActive = true
    var plays = Dictionary<Int, Int>()
    var stalemate = 0
    var gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    var grid = [[0,0,0], [0,0,0], [0,0,0]]
    var gameOver = true
 
    @IBOutlet weak var newGameButton: UIButton!

    @IBOutlet weak var staticImage: UIImageView!
    
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    @IBOutlet weak var image5: UIImageView!
    @IBOutlet weak var image6: UIImageView!
    @IBOutlet weak var image7: UIImageView!
    @IBOutlet weak var image8: UIImageView!
    @IBOutlet weak var image9: UIImageView!

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var button9: UIButton!
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        if (gameState[sender.tag] == 0) {
            gameState[sender.tag] = player
            if (player == 1)
            {
                sender.setImage(UIImage(named: "x_png"), for: UIControlState())
                player = 2
            }
            else
            {
                sender.setImage(UIImage(named: "o_png"), for: UIControlState())
                player = 1
            }
            
            checkForWinner()
        }
        

    }
    
    func checkForWinner() {
        
        let winner = ["Player1" : 0, "Player2" : 1]
        for (key, value)  in winner {
            
            if ((plays[1] == value && plays[2] == value && plays[3] == value))
                || ((plays[4] == value && plays[5] == value && plays[6] == value))
                || ((plays[7] == value && plays[8] == value && plays[9] == value))
                || ((plays[1] == value && plays[4] == value && plays[7] == value))
                || ((plays[2] == value && plays[5] == value && plays[8] == value))
                || ((plays[3] == value && plays[6] == value && plays[9] == value))
                || ((plays[1] == value && plays[5] == value && plays[9] == value))
                || ((plays[3] == value && plays[5] == value && plays[7] == value)) {
                gameOver = true
                newGameButton.isHidden = false
            }
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}



