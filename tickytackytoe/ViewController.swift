//
//  ViewController.swift
//  tickytackytoe
//
//  Created by Kenneth Wieschhoff on 10/17/17.
//  Copyright © 2017 Kenneth Wieschhoff. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    enum Player {
        case device
        case user
        case none
    }

    enum Locations {
        case top
        case middleHorz
        case bottom
        case left
        case middleVert
        case right
        case diagLeftRight
        case diagRightLeft

    }

    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn5: UIButton!
    @IBOutlet weak var btn6: UIButton!
    @IBOutlet weak var btn7: UIButton!
    @IBOutlet weak var btn8: UIButton!
    @IBOutlet weak var btn9: UIButton!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var resetBtn: UIButton!
    
    var btns = [UIButton]()
    var gameboard = [UIButton:Player]()
    
    var gameRunning = true

    var topHorizontalCells = [UIButton]()
    var middleHorizontalCells =  [UIButton]()
    var bottomHorizontalCells = [UIButton]()
    var leftVerticalCells = [UIButton]()
    var middleVerticalCells = [UIButton]()
    var rightVerticalCells = [UIButton]()
    var leftDiaganolCells = [UIButton]()
    var rightDiaganolCells = [UIButton]()
    var allCellCombinations = [[UIButton]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        btns = [btn1,btn2,btn3,btn4,btn5,btn6,btn7,btn8,btn9]
        
        topHorizontalCells = [btn1, btn2, btn3]
        middleHorizontalCells = [btn4, btn5, btn6]
        bottomHorizontalCells = [btn7, btn8, btn9]
        leftVerticalCells = [btn1, btn4, btn7]
        middleVerticalCells = [btn2, btn5, btn8]
        rightVerticalCells = [btn3, btn6, btn9]
        
        leftDiaganolCells = [btn1, btn5, btn9]
        rightDiaganolCells = [btn3, btn5, btn7]
        
        allCellCombinations = [topHorizontalCells, middleHorizontalCells, bottomHorizontalCells,
                                   leftVerticalCells, middleVerticalCells, rightVerticalCells,
                                   leftDiaganolCells, rightDiaganolCells]

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func buttonClicked ( sender: UIButton) {
        if !gameRunning {
            return
        }
        if gameboard[sender] == nil {
            gameboard[sender] = .user
            sender.setTitle("X", for: .normal)
        }
        
        checkForWin()
        
        deviceTurn()
        checkForWin()
    }
    
    @IBAction func reset(sender: UIButton) {
        gameRunning = true

        gameboard.removeAll()
        for btn in btns {
            btn.setTitle("", for: .normal)
        }
        
        resetBtn.isHidden = true
        messageLabel.isHidden = true
    }
    
    func checkForWin(){
        
        if !gameRunning {
            return
        }

        let whoWon = ["I":Player.device,"You":Player.user, "No one":Player.none]
        if gameboard.values.count == 9 {
            messageLabel.isHidden = false
            messageLabel.text = "No one won!"
            resetBtn.isHidden = false
            gameRunning = false
        }
        
        for (key,value) in whoWon {
            if ((gameboard[btn7] == value && gameboard[btn8] == value && gameboard[btn9] == value) || //bottom
                (gameboard[btn4] == value && gameboard[btn5] == value && gameboard[btn6] == value) || //middle
                (gameboard[btn1] == value && gameboard[btn2] == value && gameboard[btn3] == value) || //top
                (gameboard[btn1] == value && gameboard[btn4] == value && gameboard[btn6] == value) || //left side
                (gameboard[btn2] == value && gameboard[btn5] == value && gameboard[btn8] == value) || //middle
                (gameboard[btn3] == value && gameboard[btn6] == value && gameboard[btn9] == value) || //right side
                (gameboard[btn1] == value && gameboard[btn5] == value && gameboard[btn9] == value) || //diagonal left to right
                (gameboard[btn3] == value && gameboard[btn5] == value && gameboard[btn7] == value)){//diagonal right to left
                messageLabel.isHidden = false
                messageLabel.text = "Winner winner, chicken dinner! \(key) won!"
                resetBtn.isHidden = false
                gameRunning = false

            }
        }
    }
    func deviceTurn() {
        
        for cellRow in allCellCombinations {
            
            let occupiedCells = cellRow.filter({ (btn) -> Bool in
                gameboard[btn] == .device
                
            })
            
            if occupiedCells.count == 2 {
                let emptyCells = cellRow.filter({ (btn) -> Bool in
                    gameboard[btn] == nil
                    
                })
                if !emptyCells.isEmpty {
                    let cell = emptyCells.first!
                    gameboard[cell] = .device
                    cell.setTitle("O", for: .normal)
                    return
                }
            }
        }

        for cellRow in allCellCombinations {
            
            let occupiedCells = cellRow.filter({ (btn) -> Bool in
                gameboard[btn] == .user
                
            })
            
            if occupiedCells.count == 2 {
                let emptyCells = cellRow.filter({ (btn) -> Bool in
                    gameboard[btn] == nil
                    
                })
                if !emptyCells.isEmpty {
                    let cell = emptyCells.first!
                    gameboard[cell] = .device
                    cell.setTitle("O", for: .normal)
                    return
                }
            }
        }

        if gameboard[btn5] == nil {
            btn5.setTitle("O", for: .normal)
            gameboard[btn5] = .device
            return
        }
        for btn in btns {
            if gameboard[btn] == nil {
                btn.setTitle("O", for: .normal)
                gameboard[btn] = .device
                return
            }
        }
    }


}

