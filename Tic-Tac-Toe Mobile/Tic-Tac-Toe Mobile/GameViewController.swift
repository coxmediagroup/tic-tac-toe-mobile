//
//  GameViewController.swift
//  Tic-Tac-Toe Mobile
//
//  Created by Dave Haupert on 10/10/17.
//  Copyright © 2017 DDH Software. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

   @IBOutlet weak var playerScore: UILabel!
   @IBOutlet weak var siriScore: UILabel!

   @IBOutlet weak var button0: UIButton!
   @IBOutlet weak var button1: UIButton!
   @IBOutlet weak var button2: UIButton!
   
   @IBOutlet weak var button3: UIButton!
   @IBOutlet weak var button4: UIButton!
   @IBOutlet weak var button5: UIButton!
   
   @IBOutlet weak var button6: UIButton!
   @IBOutlet weak var button7: UIButton!
   @IBOutlet weak var button8: UIButton!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view, typically from a nib.
   }

   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }

   @IBAction func boardButtonPressed(_ sender: UIButton) {
      sender.setTitle("X", for: .normal)
   }
   
   @IBAction func newGamePressed(_ sender: UIBarButtonItem) {
      
   }
   
   

}

