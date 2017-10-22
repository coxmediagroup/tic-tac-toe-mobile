package com.purrprogramming.unbeatabletictactoe

/**
 *
 * Created by Lance Gleason on 10/20/17 of Polyglot Programming LLC.
 *
 * The main AI engine for the computer.
 *
 * Web: http://www.polygotprogramminginc.com
 * Twitter: @lgleasain
 * Github: @lgleasain
 *
 */
class MinMaxAIPlayer(board: Board) {

  val NUM_ROWS = 3//.ROW
  val NUM_COLUMNS = 3//board.COL

  val cells = board.cells


  var myBoardElementType: BoardElementType
  var oppBoardElementType: BoardElementType

  init {
    myBoardElementType = BoardElementType.EMPTY
    oppBoardElementType = BoardElementType.EMPTY
  }

  fun setBoardElementType(boardElementType: BoardElementType) {
    myBoardElementType = boardElementType
    oppBoardElementType = when (myBoardElementType) {
      BoardElementType.X -> BoardElementType.O
      else -> BoardElementType.X
    }
  }

  /**
   * move kicks off the engine and begins the computations.
   */
  fun move(): Array<Int>? {
    val result = minimax(7, myBoardElementType)
    return arrayOf(result[1], result[2])
  }

  /**
   * The main recursive minmax method.
   */
  fun minimax(depth: Int, player: BoardElementType): Array<Int> {
    val nextMoves: MutableList<BoardElement> = generateMoves()

    var bestScore = when (myBoardElementType) {
      player -> Int.MIN_VALUE
      else -> Int.MAX_VALUE
    }
    var currentScore: Int
    var bestRow = -1
    var bestCol = -1

    if (nextMoves.isEmpty() || depth == 0) {
      bestScore = evaluate()
    } else {
      nextMoves.forEach(fun(move: BoardElement) {
        cells[move.row][move.column]?.content = player

        if (player == myBoardElementType) {
          currentScore = minimax(depth - 1, oppBoardElementType)[0]
          if (currentScore > bestScore) {
            bestScore = currentScore
            bestRow = move.row
            bestCol = move.column
          }
        } else {
          currentScore = minimax(depth - 1, myBoardElementType)[0]
          if (currentScore < bestScore) {
            bestScore = currentScore
            bestRow = move.row
            bestCol = move.column
          }
        }
        cells[move.row][move.column]?.content = BoardElementType.EMPTY
      })
    }
    return arrayOf(bestScore, bestRow, bestCol)
  }

  /**
   * generates possible moves for the board at the current state.
   */
  fun generateMoves(): MutableList<BoardElement> {
    val nextMoves: MutableList<BoardElement> = mutableListOf()

    if (hasWon(myBoardElementType) || hasWon(oppBoardElementType)) {
      return nextMoves
    }

    for (row in 0 until NUM_ROWS) {
      (0 until NUM_COLUMNS)
          .asSequence()
          .filter { cells[row][it]?.content == BoardElementType.EMPTY }
          .forEach { nextMoves.add(BoardElement(row, it)) }
    }
    return nextMoves
  }

  val winningPatterns: Array<Int> = arrayOf(
      0b111000000, 0b000111000, 0b000000111, // rows
      0b100100100, 0b010010010, 0b001001001, // cols
      0b100010001, 0b001010100)               // diagonals

  fun hasWon(thePlayer: BoardElementType): Boolean {
    var pattern = 0b000000000
    for (row in 0 until NUM_ROWS) {
      (0 until NUM_COLUMNS)
          .asSequence()
          .filter { cells[row][it]?.content == thePlayer }
          .forEach { pattern = pattern or (1 shl (row * NUM_COLUMNS + it)) }
    }

    winningPatterns
        .asSequence()
        .filter { (pattern and it) == it }
        .forEach { return true }

    return false
  }

  /**
   * evaluates the potential scores.
   */
  fun evaluate(): Int {
    var score = 0
    score += evaluateLine(0, 0, 0, 1, 0, 2)  // row 0
    score += evaluateLine(1, 0, 1, 1, 1, 2)  // row 1
    score += evaluateLine(2, 0, 2, 1, 2, 2)  // row 2
    score += evaluateLine(0, 0, 1, 0, 2, 0)  // col 0
    score += evaluateLine(0, 1, 1, 1, 2, 1)  // col 1
    score += evaluateLine(0, 2, 1, 2, 2, 2)  // col 2
    score += evaluateLine(0, 0, 1, 1, 2, 2)  // diagonal
    score += evaluateLine(0, 2, 1, 1, 2, 0)  // alternate diagonal
    return score
  }

  /**
   * score the individual line.
   */
  fun evaluateLine(row1: Int, col1: Int, row2: Int, col2: Int, row3: Int, col3: Int): Int {
    var score = 0

    // First cell
    if (cells[row1][col1]?.content == myBoardElementType) {
      score = 1
    } else if (cells[row1][col1]?.content == oppBoardElementType) {
      score = -1
    }

    // Second cell
    if (cells[row2][col2]?.content == myBoardElementType) {
      if (score == 1) {   // cell1 is myBoardElementType
        score = 10
      } else if (score == -1) {  // cell1 is oppBoardElementType
        return 0
      } else {  // cell1 is empty
        score = 1
      }
    } else if (cells[row2][col2]?.content == oppBoardElementType) {
      if (score == -1) { // cell1 is oppBoardElementType
        score = -10
      } else if (score == 1) { // cell1 is myBoardElementType
        return 0
      } else {  // cell1 is empty
        score = -1
      }
    }

    // Third cell
    if (cells[row3][col3]?.content == myBoardElementType) {
      if (score > 0) {  // cell1 and/or cell2 is myBoardElementType
        score *= 10
      } else if (score < 0) {  // cell1 and/or cell2 is oppBoardElementType
        return 0
      } else {  // cell1 and cell2 are empty
        score = 1
      }
    } else if (cells[row3][col3]?.content == oppBoardElementType) {
      if (score < 0) {  // cell1 and/or cell2 is oppBoardElementType
        score *= 10
      } else if (score > 1) {  // cell1 and/or cell2 is myBoardElementType
        return 0
      } else {  // cell1 and cell2 are empty
        score = -1
      }
    }
    return score
  }


}