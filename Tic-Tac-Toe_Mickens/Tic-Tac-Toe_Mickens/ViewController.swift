//
//  ViewController.swift
//  Tic-Tac-Toe_Mickens
//
//  Created by Maurice Mickens on 5/6/17.
//
//

import UIKit

class BoardCell:UICollectionViewCell{
    @IBOutlet weak var pieceImageView: UIImageView!
    var piece:Piece?{
        didSet{
            guard let piece = piece else { return }
            if piece == .X{
                pieceImageView.image = UIImage(named: "x-mark")
            } else if piece == .O {
                pieceImageView.image = UIImage(named: "circle-mark")
            } else{
                self.backgroundColor = UIColor.gray
            }
        }
    }
}

class ViewController: UIViewController, CustomCollectionVC {
    
    // const
    let N = 9
    
    // private
    fileprivate var humanMove = false
    fileprivate var computerMove = false
    fileprivate var board:Array<Piece>!
    
    // public 
    @IBOutlet weak var computerBtn: UIButton!
    @IBOutlet weak var humanBtn: UIButton!
    @IBOutlet weak var collectionView:UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        board = Array(repeating: Piece.empty, count:N)
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
            let bestMove = makeMove()
            addMoveToBoard(move:bestMove)
            notifyHumanToMove()
        } else{
            notifyHumanToMove()
        }
    }
    
    func addMoveToBoard(move:Move){
        for i in 0..<board.count{
            if board[i] == .empty{
                if i == move.cell {
                    board[i] = .X
                }
            }
        }
        collectionView.reloadData()
    }
    
    func notifyHumanToMove(){
        computerMove = false
        humanMove = true
        humanBtn.titleLabel?.text = "Its Your Move"
    }
    
    func notifyComputerToMove(){
        computerMove = true
        humanMove = false
        computerBtn.titleLabel?.text = "Its My Move"
        let bestMove = makeMove()
        addMoveToBoard(move:bestMove)
        notifyHumanToMove()
    }
    
    func resetGame(){
        for i in 0..<N{
            board[i] = .empty
        }
        
        collectionView.reloadData()
    }
    
    func makeMove()->Move{
        
        var bestValue = -1000
        var bestMove = Move(cell: -1)
        
        // Transverse entire board for empty cells and return cell with the best chance of AI winning.
        for i in 0..<board.count{
            if board[i] == .empty{
                
                // computer move
                board[i] = .X
                
                // Determine if this is the best move
                let value = minimax(board: &board, max: true, depth:0)
                
                // reset move
                board[i] = .empty
                
                // Update best move
                if value > bestValue{
                    bestMove.cell = i
                    bestValue = value
                }
            }
        }
        
        print("Best move value is \(bestValue)")
        return bestMove
    }
    
    func minimax(board:inout Array<Piece>!, max:Bool, depth:Int)->Int{
        let score = hasWon(board: board)
        
        // We have a winner
        if score == 10 || score == -10 { return score }
        
        // We have a draw
        if !areMovesLeft(board: board) { return 0 }
        
        // Computer's move
        if max{
            var best = 1000
            for i in 0..<N{
                if board[i] == .empty{
                    
                    // computer move
                    board[i] = .X
                    
                    // Recursive call to minimax
                    best = minimax(board: &board, max: true, depth: depth + 1)
                    
                    // undo move
                    board[i] = .empty
                }
            }
            
            return best
            
        } else{
            var best = -1000
            for i in 0..<N{
                if board[i] == .empty{
                    
                    // human move
                    board[i] = .O
                    
                    // Recursive call to minimax
                    best = minimax(board: &board, max: false, depth: depth + 1)
                    
                    // undo move
                    board[i] = .empty
                }
            }
            
            return best
        }

    }
    
    func areMovesLeft(board:Array<Piece>)->Bool{
        for i in 0..<board.count{
            if board[i] == .empty{
                return true
            }
        }
        return false
    }
    
    func hasWon(board:Array<Piece>)->Int{
        /* Check Rows */
        if getWinner(p1: board[0], p2: board[1], p3: board[2]) {
            return board[0] == .X ? +10 : -10
        } else if getWinner(p1: board[3], p2: board[4], p3: board[5]) {
            return board[3] == .X ? +10 : -10
        } else if getWinner(p1: board[6], p2: board[7], p3: board[8]) {
            return board[6] == .X ? +10 : -10
        }
        
        /* Check Columns */
        if getWinner(p1: board[0], p2: board[3], p3: board[6]) {
            return board[0] == .X ? +10 : -10
        } else if getWinner(p1: board[1], p2: board[4], p3: board[7]) {
            return board[1] == .X ? +10 : -10
        } else if getWinner(p1: board[2], p2: board[5], p3: board[8]) {
            return board[2] == .X ? +10 : -10
        }
        
        /* Check Diagonal*/
        if getWinner(p1: board[0], p2: board[4], p3: board[8]) {
            return board[0] == .X ? +10 : -10
        } else if getWinner(p1: board[2], p2: board[4], p3: board[6]) {
            return board[2] == .X ? +10 : -10
        }
        
        return 0
    }
    
    func getWinner(p1:Piece, p2:Piece, p3:Piece)->Bool{
        if p1 == Piece.empty{
            return false
        }
        return p1 == p2 && p2 == p3
    }
    
    func notifyTurnToMove(){
        
    }
}

extension ViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return board.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: BoardCell.self), for: indexPath)
        guard let boardCell = cell as? BoardCell else { return cell }
        let piece = board[indexPath.row]
        boardCell.piece = piece
        boardCell.backgroundColor = UIColor.gray
        return boardCell
    }
}


extension ViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard (collectionView.cellForItem(at: indexPath) as? BoardCell) != nil else { return }
        if humanMove && !computerMove{
            board[indexPath.row] = .O
            notifyComputerToMove()
        }
        
    }
}

