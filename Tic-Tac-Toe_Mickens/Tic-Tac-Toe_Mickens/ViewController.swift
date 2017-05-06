//
//  ViewController.swift
//  Tic-Tac-Toe_Mickens
//
//  Created by Maurice Mickens on 5/6/17.
//
//

import UIKit

class BoardCell:UICollectionViewCell{
    
}

class ViewController: UIViewController, CustomCollectionVC {
    
    let N = 3
    @IBOutlet weak var collectionView:UICollectionView!
    var humanMove = false
    var computerMove = false
    var board:Array<[Piece]>!

    override func viewDidLoad() {
        super.viewDidLoad()
        board = Array(repeating: Array(repeating: Piece.empty, count:N), count: N)
        configCollectionView(delegate: self)
        configureCollectionViewItemSize(collectionView: collectionView, layout: collectionView.collectionViewLayout as! UICollectionViewFlowLayout)
    }
    
    @IBAction func computerStart(_ sender: Any) {
        startNewGame(playerMove: Player.Computer)
    }
    
    @IBAction func humanStart(_ sender: Any) {
        startNewGame(playerMove: Player.Human)
    }
    
    func startNewGame(playerMove:Player){
        resetGame()
        if playerMove == .Computer{
            computerMove = true
            humanMove = false
            makeMove()
        } else{
            computerMove = false
            humanMove = true
            notifyTurnToMove()
        }
    }
    
    
    func resetGame(){
        
    }
    
    func makeMove(){
        // Transverse entire board for empty cells and return cell with the best chance of AI winning.
        for i in 0..<N{
            for j in 0..<N{
                
                if board[i][j] == .empty{
                    
                    // computer move
                    board[i][j] = .X
                    
                    // Determine if this is the best move
                    
                }
            }
        }
    }
    
    func notifyTurnToMove(){
        
    }
}

extension ViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return 9
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: BoardCell.self), for: indexPath)
        guard let boardCell = cell as? BoardCell else { return cell }
        boardCell.backgroundColor = UIColor.red
        return boardCell
    }
}


extension ViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let boardCell = collectionView.cellForItem(at: indexPath) as? BoardCell else { return }
        boardCell.backgroundColor = UIColor.green
        
    }
}

