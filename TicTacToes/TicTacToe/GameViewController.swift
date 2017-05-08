//
//  GameViewController.swift
//  TicTacToe
//
//  Created by Nicholas Bosak on 5/3/17.
//  Copyright © 2017 Nicholas Bosak. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
	
	@IBOutlet weak var xxBtn: UIButton!
	@IBOutlet weak var ooBtn: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
	}
	
	@IBAction func xxBtnPress(_ sender: UIButton) {
		startGame("X")
	}
	
	@IBAction func ooBtnPress(_ sender: UIButton) {
		startGame("O")
	}
	
	func startGame(_ selectedXO: String) {
		let vc = storyboard?.instantiateViewController(withIdentifier: "GameBoard") as! BoardViewController
		vc.selectedXO = selectedXO
		navigationController?.pushViewController(vc, animated: true)
		
	}
}
