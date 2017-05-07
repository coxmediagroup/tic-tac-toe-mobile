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
    let N = 3
    
    // private
    fileprivate var humanMove = false
    fileprivate var computerMove = false
    fileprivate var board:Array<[Piece]>!
    
    // public 
    @IBOutlet weak var computerBtn: UIButton!
    @IBOutlet weak var humanBtn: UIButton!
    @IBOutlet weak var collectionView:UICollectionView!

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
            let bestMove = makeMove()
            addMoveToBoard(move:bestMove)
            notifyHumanToMove()
        } else{
            notifyHumanToMove()
        }
    }
    
    func addMoveToBoard(move:Move){
        for i in 0..<N{
            for j in 0..<N{
                if board[i][j] == .empty{
                    if i == move.row && j == move.col{
                        board[i][j] = .X
                    }
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
        
    }
    
    func makeMove()->Move{
        
        var bestValue = -1000
        var bestMove = Move(row: -1, col: -1)
        
        // Transverse entire board for empty cells and return cell with the best chance of AI winning.
        for i in 0..<N{
            for j in 0..<N{
                
                if board[i][j] == .empty{
                    
                    // computer move
                    board[i][j] = .X
                    
                    // Determine if this is the best move
                    let value = minimax(board: &board, max: true, depth:0)
                    
                    // reset move
                    board[i][j] = .empty
                    
                    // Update best move
                    if value > bestValue{
                        bestMove.row = i
                        bestMove.col = j
                        bestValue = value
                    }
                }
            }
        }
        
        print("Best move value is \(bestValue)")
        return bestMove
    }
    
    func minimax(board:inout Array<[Piece]>!, max:Bool, depth:Int)->Int{
        let score = hasWon(board: board)
        
        // We have a winner
        if score == 10 || score == -10 { return score }
        
        // We have a draw
        if !areMovesLeft(board: board) { return 0 }
        
        // Computer's move
        if max{
            var best = 1000
            for i in 0..<N{
                for j in 0..<N{
                    if board[i][j] == .empty{
                        
                        // computer move
                        board[i][j] = .X
                        
                        // Recursive call to minimax
                        best = minimax(board: &board, max: true, depth: depth + 1)
                        
                        // undo move
                        board[i][j] = .empty
                    }
                }
            }
            
            return best
            
        } else{
            var best = -1000
            for i in 0..<N{
                for j in 0..<N{
                    if board[i][j] == .empty{
                        
                        // human move
                        board[i][j] = .O
                        
                        // Recursive call to minimax
                        best = minimax(board: &board, max: false, depth: depth + 1)
                        
                        // undo move
                        board[i][j] = .empty
                    }
                }
            }
            
            return best
        }

    }
    
    func areMovesLeft(board:Array<[Piece]>)->Bool{
        for i in 0..<N{
            for j in 0..<N{
                if board[i][j] == .empty{
                    return true
                }
            }
        }
        return false
    }
    
    func hasWon(board:Array<[Piece]>)->Int{
        for i in 0..<board.count{
            /* Check Rows */
            if getWinner(p1: board[i][0], p2: board[i][1], p3: board[i][2]) {
                return board[i][0] == .X ? +10 : -10
            }
            
            /* Check Columns */
            if getWinner(p1: board[0][i], p2: board[1][i], p3: board[2][i]) {
                return board[0][i] == .X ? +10 : -10
            }
            
            /* Check Diagonal*/
            if getWinner(p1: board[0][0], p2: board[1][1], p3: board[2][2]) {
                return board[0][0] == .X ? +10 : -10
            }
            
            if getWinner(p1: board[0][2], p2: board[1][1], p3: board[2][0]) {
                return board[0][2] == .X ? +10 : -10
            }
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
        return 9
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: BoardCell.self), for: indexPath)
        guard let boardCell = cell as? BoardCell else { return cell }
        let flattened = Array(board.joined())
        let piece = flattened[indexPath.row]
        boardCell.piece = piece
        boardCell.backgroundColor = UIColor.gray
        return boardCell
    }
}


extension ViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard (collectionView.cellForItem(at: indexPath) as? BoardCell) != nil else { return }
        if humanMove && !computerMove{
            insertIntoBoard(row: indexPath.row)
            notifyComputerToMove()
        }
        
    }
    
    func insertIntoBoard(row:Int){
        var count = -1
        for i in 0..<N{
            for j in 0..<N{
                count += 1
                if count == row {
                    board[i][j] = .O
                }
            }
        }
        collectionView.reloadData()
    }
}

