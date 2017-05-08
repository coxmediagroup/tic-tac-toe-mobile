//
//  BoardViewController.swift
//  TicTacToe
//
//  Created by Nicholas Bosak on 5/3/17.
//  Copyright © 2017 Nicholas Bosak. All rights reserved.
//

import UIKit

class BoardViewController: UIViewController {
	
	// Possible spaces on the board
	@IBOutlet var boardPlace1: UIButton!
	@IBOutlet var boardPlace2: UIButton!
	@IBOutlet var boardPlace3: UIButton!
	@IBOutlet var boardPlace4: UIButton!
	@IBOutlet var boardPlace5: UIButton!
	@IBOutlet var boardPlace6: UIButton!
	@IBOutlet var boardPlace7: UIButton!
	@IBOutlet var boardPlace8: UIButton!
	@IBOutlet var boardPlace9: UIButton!
	
	var turn = 0
	var selectedXO: String!
	var boardBtns: [UIButton]!
	var player = 0
	var movesLeft = [5, 0, 0, 0, 0, 0, 0, 0, 0, 0]
	var boardCombos = [ [1,2,3],
	                            [4,5,6],
	                            [7,8,9],
	                            [1,4,7],
	                            [2,5,8],
	                            [3,6,9],
	                            [1,5,9],
	                            [7,5,3]]
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		boardBtns = [boardPlace1,
		             boardPlace2,
		             boardPlace3,
		             boardPlace4,
		             boardPlace5,
		             boardPlace6,
		             boardPlace7,
		             boardPlace8,
		             boardPlace9]
		
		firstPlay()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		print("Player chose \(selectedXO)")
		
	}
	
	func firstPlay() {
		turn = getRandomTurn()
		print("Turn: \(turn)")
		if turn == 2 {
			player = 2
			makeAIMove()
		} else {
			player = 1
		}
	}
	
	func getRandomTurn() -> Int {
		return Int(arc4random_uniform(UInt32(2))) + 1
	}
	
	func restartGame() {
		player = 1
		movesLeft = [5, 0, 0, 0, 0, 0, 0, 0, 0, 0]
		for img in boardBtns {
			img.setImage(nil, for: UIControlState())
		}
	}
	
	func delay(_ delay:Double, closure:@escaping ()->()) {
		DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
	}
	
	func makeMove(_ player: Int, position: Int) {
		movesLeft[position] = player
		print("Moves Left: \(movesLeft)")
		
		delay(1) {
			if self.selectedXO == "X" {
				self.boardBtns[position - 1].setImage(UIImage(named: "o"), for: UIControlState())
			} else {
				self.boardBtns[position - 1].setImage(UIImage(named: "x"), for: UIControlState())
			}
			
			if self.playerWon(player, board: self.movesLeft) {
				self.delay(2, closure: {
					self.showAlert("The Computer won.")
					self.restartGame()
				})
				
			} else if self.boardFull() {
				self.showAlert("It's a tie!")
				self.restartGame()
			}
			self.player = 1
		}
		
	}
	
	func makeAIMove() {
		var movesLeftCopy = movesLeft
		for i in 1...9 {
			if movesLeftCopy[i] == 0 {
				movesLeftCopy[i] = player
				print("Board For 1 \(movesLeftCopy)")
				if playerWon(player, board: movesLeftCopy) {
					makeMove(player, position: i)
					print("Computer can win next move")
					return
				} else {
					movesLeftCopy[i] = 0
				}
			}
		}
		
		movesLeftCopy = movesLeft
		for i in 1...9 {
			if movesLeftCopy[i] == 0 {
				movesLeftCopy[i] = 1
				print("Board For 2 \(movesLeftCopy)")
				if playerWon(1, board: movesLeftCopy) {
					makeMove(player, position: i)
					print("Player could win next move")
					return
				} else {
					movesLeftCopy[i] = 0
				}
			}
		}
		
		let cornerMoves = [1, 3, 7, 9]
		for move in cornerMoves {
			if movesLeft[move] == 0 {
				makeMove(player, position: move)
				print("Taking corner")
				return
			}
		}
		
		let center = 5
		if movesLeft[center] == 0 {
			makeMove(player, position: center)
			print("Taking center")
			return
		}
		
		let sideMoves = [2, 4, 6, 8]
		for move in sideMoves {
			if movesLeft[move] == 0 {
				makeMove(player, position: move)
				print("Taking side move")
				return
			}
		}
	}
	
	func getRandomMove(_ possibleMoves: [Int]) -> Int {
		let randomIndex = Int(arc4random_uniform(UInt32(possibleMoves.count)))
		return possibleMoves[randomIndex]
	}
	
	func playerWon(_ player: Int, board: [Int]) -> Bool {
		for combination in boardCombos {
			if (board[combination[0]] != 0) && board[combination[0]] == board[combination[1]] && board[combination[1]] == board[combination[2]] {
				print("Player \(player) won the game!")
				return true
			}
		}
		return false
	}
	
	func boardFull() -> Bool {
		for move in movesLeft {
			if move == 0 {
				return false
			}
		}
		return true
	}
		
	@IBAction func playBtn(_ sender: AnyObject) {
		if movesLeft[sender.tag] == 0 && player == 1 {
			
			if selectedXO == "X" {
				sender.setImage(UIImage(named: "x"), for: UIControlState())
			} else {
				sender.setImage(UIImage(named: "o"), for: UIControlState())
			}
			
			movesLeft[sender.tag] = player
			print("Moves Left: \(movesLeft)")
			if playerWon(player, board: movesLeft) {
				print("Great job Player!")
				showAlert("You Won!")
				restartGame()
				return
			} else if boardFull() {
				showAlert("It's a draw!")
				restartGame()
			}
			player = 2
			makeAIMove()
		}
	}
}

extension BoardViewController {
	
	func showAlert(_ message: String) {
		let ac = UIAlertController(title: "Game Over", message: message, preferredStyle: .alert)
		
		ac.addAction(UIAlertAction(title: "Ok", style: .default) { (action) in
			self.navigationController?.popViewController(animated: true)
		})
		present(ac, animated: true, completion: nil)
	}
}


