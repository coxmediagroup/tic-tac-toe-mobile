//
//  Model.swift
//  Tic-Tac-Toe_Mickens
//
//  Created by Maurice Mickens on 5/6/17.
//
//

import Foundation

struct Move{
    var cell:Int
    var score:Int
}

enum Piece {
    case empty
    case X  // computer
    case O // human
}

enum Player{
    case Human
    case Computer
}
