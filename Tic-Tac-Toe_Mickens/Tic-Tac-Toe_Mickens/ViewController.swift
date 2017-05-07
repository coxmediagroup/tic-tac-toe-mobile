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
                pieceImageView.image = nil
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
    fileprivate var humanPiece:Piece!
    fileprivate var computerPiece:Piece!
    
    // public 
    @IBOutlet weak var welcomeLbl: UILabel!
    @IBOutlet weak var startGameBtn: UIButton!
    @IBOutlet weak var chooseLbl: UILabel!
    @IBOutlet weak var xButton: UIButton!
    @IBOutlet weak var oButton: UIButton!
    @IBOutlet weak var collectionView:UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        board = Array(repeating: Piece.empty, count:N)
        showWelcomeControls(flip: true)
        showSelectionControls(flip: true)
        configCollectionView(delegate: self)
        configureCollectionViewItemSize(collectionView: collectionView, layout: collectionView.collectionViewLayout as! UICollectionViewFlowLayout)
    }
    
    func showWelcomeControls(flip:Bool){
        welcomeLbl.isEnabled = flip
        welcomeLbl.isHidden = !flip
        startGameBtn.isEnabled = flip
        startGameBtn.isHidden = !flip
    }
    
    func showSelectionControls(flip:Bool){
        xButton.isEnabled = !flip
        xButton.isHidden = flip
        oButton.isEnabled = !flip
        oButton.isHidden = flip
        chooseLbl.isEnabled = !flip
        chooseLbl.isHidden = flip
    }
    
    func showMessage(message:String, flip:Bool){
        welcomeLbl.isEnabled = flip
        welcomeLbl.isHidden = !flip
        welcomeLbl.text = message
    }
    
    func showButton(flip:Bool){
        startGameBtn.isEnabled = flip
        startGameBtn.isHidden = !flip
    }
    
    @IBAction func startGameBtnPressed(_ sender: Any) {
        resetGame()
        showPlayerOptions()
    }
    
    func showPlayerOptions(){
        showWelcomeControls(flip: false)
        showSelectionControls(flip: false)
    }
    
    @IBAction func xPieceSelected(_ sender: Any) {
        humanPiece = .X
        computerPiece = .O
        showSelectionControls(flip: true)
        showMessage(message: "You chose X, you go first.", flip: true)
        let when = DispatchTime.now() + 1
        DispatchQueue.main.asyncAfter(deadline: when) {
            // Your code with delay
            self.notifyHumanToMove(flip: true)
            self.showMessage(message: "", flip: false)
        }
    }
    
    @IBAction func oPieceSelected(_ sender: Any) {
        humanPiece = .O
        computerPiece = .X
        showSelectionControls(flip: true)
        showMessage(message: "You chose O, you go first.", flip: true)
        let when = DispatchTime.now() + 1
        DispatchQueue.main.asyncAfter(deadline: when) {
            // Your code with delay
            self.notifyHumanToMove(flip: true)
            self.showMessage(message: "", flip: false)
        }
    }
    
    func addMoveToBoard(move:Move){
        for i in 0..<board.count{
            if board[i] == .empty{
                if i == move.cell {
                    board[i] = computerPiece
                }
            }
        }
        collectionView.reloadData()
    }
    
    func notifyHumanToMove(flip:Bool){
        computerMove = !flip
        humanMove = flip
    }
    
    func notifyComputerToMove(){
        computerMove = true
        humanMove = false
        
        let bestMove = makeMove()
        addMoveToBoard(move:bestMove)
        if bestMove.score == 10 {
            // Human Player loses :(
            notifyHumanToMove(flip: false)
            showMessage(message: "Looooooooosseeerrrrrr : ), try again.", flip: true)
            showButton(flip: true)
        } else if bestMove.score == -1000{
            // Human and Computer Draw
            notifyHumanToMove(flip: false)
            showMessage(message: "It's a Draw! Bet I beat you next time :]", flip: true)
            showButton(flip: true)
        } else{
            notifyHumanToMove(flip: true)
        }
    }
    
    func resetGame(){
        for i in 0..<board.count{
            board[i] = .empty
        }
        
        collectionView.reloadData()
    }
    
    func makeMove()->Move{
        
        var newBoard = Array(repeating: Piece.empty, count:N)
        
        // Copy values from the original board
        var i = 0
        while i < board.count{
            newBoard[i] = board[i]
            i += 1
        }
        
        var bestValue = -1000
        var bestMove = Move(cell: -1, score: -1)
        
        // Transverse entire board for empty cells and return cell with the best chance of AI winning.
        for i in 0..<board.count{
            if newBoard[i] == .empty{
                
                // computer move
                newBoard[i] = computerPiece
                
                // Determine if this is the best move
                let value = minimax(board: &newBoard, isMax: false, depth:0)
                
                // reset move
                newBoard[i] = .empty
                
                // Update best move
                if value > bestValue{
                    bestMove.cell = i
                    bestValue = value
                }
            }
        }
        
        print("Best move value is \(bestValue)")
        bestMove.score = bestValue
        return bestMove
    }
    
    func minimax(board:inout Array<Piece>, isMax:Bool, depth:Int)->Int{
        let score = hasWon(board: board)
        
        // AI wins
        if score == 10{
            return score - depth
        }
        
        // Humans wins
        if score == -10{
            return score + depth
        }
        
        // We have a draw
        if !areMovesLeft(board: board) { return 0 }
        
        // Computer's move
        if isMax{
            var best = -1000
            for i in 0..<board.count{
                if board[i] == .empty{
                    
                    // computer move
                    board[i] = computerPiece
                    
                    // Recursive call to minimax
                    best = max(best, minimax(board: &board, isMax: !isMax, depth: depth + 1))
                    
                    // undo move
                    board[i] = .empty
                }
            }
            
            return best
            
        } else{
            var best = 1000
            for i in 0..<board.count{
                if board[i] == .empty{
                    
                    // human move
                    board[i] = humanPiece
                    
                    // Recursive call to minimax
                    best = min(best, minimax(board: &board, isMax: !isMax, depth: depth + 1))
                    
                    // undo move
                    board[i] = .empty                }
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
            return board[0] == computerPiece ? +10 : -10
        } else if getWinner(p1: board[3], p2: board[4], p3: board[5]) {
            return board[3] == computerPiece ? +10 : -10
        } else if getWinner(p1: board[6], p2: board[7], p3: board[8]) {
            return board[6] == computerPiece ? +10 : -10
        }
        
        /* Check Columns */
        if getWinner(p1: board[0], p2: board[3], p3: board[6]) {
            return board[0] == computerPiece ? +10 : -10
        } else if getWinner(p1: board[1], p2: board[4], p3: board[7]) {
            return board[1] == computerPiece ? +10 : -10
        } else if getWinner(p1: board[2], p2: board[5], p3: board[8]) {
            return board[2] == computerPiece ? +10 : -10
        }
        
        /* Check Diagonal*/
        if getWinner(p1: board[0], p2: board[4], p3: board[8]) {
            return board[0] == computerPiece ? +10 : -10
        } else if getWinner(p1: board[2], p2: board[4], p3: board[6]) {
            return board[2] == computerPiece ? +10 : -10
        }
        
        return 0
    }
    
    func getWinner(p1:Piece, p2:Piece, p3:Piece)->Bool{
        if p1 == Piece.empty{
            return false
        }
        return p1 == p2 && p2 == p3
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
        boardCell.backgroundColor = UIColor.blue
        return boardCell
    }
}


extension ViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard (collectionView.cellForItem(at: indexPath) as? BoardCell) != nil else { return }
        if humanMove && !computerMove{
            board[indexPath.row] = humanPiece
            collectionView.reloadData()
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                // Your code with delay
                  self.notifyComputerToMove()
            }
        }
        
    }
}

