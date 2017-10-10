//
//  Tic_Tac_Toe_MobileTests.swift
//  Tic-Tac-Toe MobileTests
//
//  Created by Dave Haupert on 10/10/17.
//  Copyright © 2017 DDH Software. All rights reserved.
//

import XCTest
@testable import Tic_Tac_Toe_Mobile

class Tic_Tac_Toe_MobileTests: XCTestCase {
   
   var board: GameBoard!
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        board = GameBoard()
      
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testBoardEmptyLogic() {

      
        board.clearBoard()
      
        // First make sure the board tests as not full
        XCTAssertFalse(board.isGameOver(), "Board is empty but marked as game over")
      
      
        // Now, let's set a few items but make sure not to win
        board.setBoardState(index: 0, state: BoardStates.x)
        board.setBoardState(index: 1, state: BoardStates.o)
        board.setBoardState(index: 2, state: BoardStates.x)

        XCTAssertFalse(board.isGameOver(), "No winner and not full, but marked as game over")

        board.setBoardState(index: 3, state: BoardStates.o)
        board.setBoardState(index: 4, state: BoardStates.o)
        board.setBoardState(index: 5, state: BoardStates.x)
         
        XCTAssertFalse(board.isGameOver(), "No winner and not full, but marked as game over")

        board.setBoardState(index: 6, state: BoardStates.o)
        board.setBoardState(index: 7, state: BoardStates.x)
        board.setBoardState(index: 8, state: BoardStates.o)
         
        XCTAssertTrue(board.isGameOver(), "No winner and full, but not marked as game over")
      
    }
   
   // test that various patterns lead to winning state
   func testWinLogic() {
      board.clearBoard()
      var winner: String?
      // Use XCTAssert and related functions to verify your tests produce the correct results.
      
      // First make sure the board tests as not full
      XCTAssertFalse(board.isGameOver(), "Board is empty but marked as game over")
      winner = board.gameWinner()
      XCTAssertNil(winner, "Winner is set when no winner")
      
      
      // Now, let's set a few items but make sure not to win
      board.setBoardState(index: 0, state: BoardStates.x)
      board.setBoardState(index: 1, state: BoardStates.x)
      board.setBoardState(index: 2, state: BoardStates.x)
      
      XCTAssertTrue(board.isGameOver(), "winner and not full, but not marked as game over")
      winner = board.gameWinner()
      XCTAssertEqual(winner, "X", "Winner is wrong")

      board.clearBoard()
      
      board.setBoardState(index: 3, state: BoardStates.o)
      board.setBoardState(index: 4, state: BoardStates.o)
      board.setBoardState(index: 5, state: BoardStates.o)
      
      XCTAssertTrue(board.isGameOver(), "winner and not full, but not marked as game over")
      winner = board.gameWinner()
      XCTAssertEqual(winner, "O", "Winner is wrong")
      
      board.clearBoard()
      
      board.setBoardState(index: 6, state: BoardStates.o)
      board.setBoardState(index: 7, state: BoardStates.o)
      board.setBoardState(index: 8, state: BoardStates.o)
      
      XCTAssertTrue(board.isGameOver(), "winner and not full, but not marked as game over")
      winner = board.gameWinner()
      XCTAssertEqual(winner, "O", "Winner is wrong")

      // check diagonal
      board.clearBoard()
      
      board.setBoardState(index: 0, state: BoardStates.o)
      board.setBoardState(index: 4, state: BoardStates.o)
      board.setBoardState(index: 8, state: BoardStates.o)
      
      XCTAssertTrue(board.isGameOver(), "winner and not full, but not marked as game over")
      winner = board.gameWinner()
      XCTAssertEqual(winner, "O", "Winner is wrong")
      
      // check reverse diagonal
      board.clearBoard()
      
      board.setBoardState(index: 2, state: BoardStates.o)
      board.setBoardState(index: 4, state: BoardStates.o)
      board.setBoardState(index: 6, state: BoardStates.o)
      
      XCTAssertTrue(board.isGameOver(), "winner and not full, but not marked as game over")
      winner = board.gameWinner()
      XCTAssertEqual(winner, "O", "Winner is wrong")
      
      // check vertical 1
      board.clearBoard()
      
      board.setBoardState(index: 0, state: BoardStates.o)
      board.setBoardState(index: 3, state: BoardStates.o)
      board.setBoardState(index: 6, state: BoardStates.o)
      
      XCTAssertTrue(board.isGameOver(), "winner and not full, but not marked as game over")
      winner = board.gameWinner()
      XCTAssertEqual(winner, "O", "Winner is wrong")
      
      
      // check vertical 2
      board.clearBoard()
      
      board.setBoardState(index: 1, state: BoardStates.o)
      board.setBoardState(index: 4, state: BoardStates.o)
      board.setBoardState(index: 7, state: BoardStates.o)
      
      XCTAssertTrue(board.isGameOver(), "winner and not full, but not marked as game over")
      winner = board.gameWinner()
      XCTAssertEqual(winner, "O", "Winner is wrong")
      
      // check vertical 3
      board.clearBoard()
      
      board.setBoardState(index: 2, state: BoardStates.x)
      board.setBoardState(index: 5, state: BoardStates.x)
      board.setBoardState(index: 8, state: BoardStates.x)
      
      XCTAssertTrue(board.isGameOver(), "winner and not full, but not marked as game over")
      winner = board.gameWinner()
      XCTAssertEqual(winner, "X", "Winner is wrong")
      
      
   }
   
   
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
