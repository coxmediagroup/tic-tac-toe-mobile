package com.purrprogramming.unbeatabletictactoe

import com.purrprogramming.unbeatabletictactoe.util.TwoDimensionalArray

/**
 *
 * Created by Lance Gleason on 10/19/17 of Polyglot Programming LLC.
 *
 * Board data class with a few helper methods.
 *
 * Web: http://www.polygotprogramminginc.com
 * Twitter: @lgleasain
 * Github: @lgleasain
 *
 */
data class Board(var leftTop: BoardElementType = BoardElementType.EMPTY,
                 var centerTop: BoardElementType = BoardElementType.EMPTY,
                 var rightTop: BoardElementType = BoardElementType.EMPTY,
                 var leftMiddle: BoardElementType = BoardElementType.EMPTY,
                 var centerMiddle: BoardElementType = BoardElementType.EMPTY,
                 var rightMiddle: BoardElementType = BoardElementType.EMPTY,
                 var leftBottom: BoardElementType = BoardElementType.EMPTY,
                 var centerBottom: BoardElementType = BoardElementType.EMPTY,
                 var rightBottom: BoardElementType = BoardElementType.EMPTY,
                 val NUM_ROWS: Int = 3,
                 val NUM_COLUMNS: Int = 3) {

  val cells = TwoDimensionalArray<BoardElement?>(NUM_ROWS, NUM_COLUMNS) { null }

  /**
   * syncs the character representations of the element with the cell array used
   * for move calculation.
   */
  fun refreshCells() {
    cells[0][0] = BoardElement(0, 0, leftTop)
    cells[0][1] = BoardElement(0, 1, centerTop)
    cells[0][2] = BoardElement(0, 2, rightTop)
    cells[1][0] = BoardElement(1, 0, leftMiddle)
    cells[1][1] = BoardElement(1, 1, centerMiddle)
    cells[1][2] = BoardElement(1, 2, rightMiddle)
    cells[2][0] = BoardElement(2, 0, leftBottom)
    cells[2][1] = BoardElement(2, 1, centerBottom)
    cells[2][2] = BoardElement(2, 2, rightBottom)
  }

  /**
   * takes a row and column number and sets the appropriate method on the board.
   */
  fun setElementFromCell(row: Int, column: Int, element: BoardElementType) {
    when {
      row == 0 && column == 0 -> leftTop = element
      row == 0 && column == 1 -> centerTop = element
      row == 0 && column == 2 -> rightTop = element
      row == 1 && column == 0 -> leftMiddle = element
      row == 1 && column == 1 -> centerMiddle = element
      row == 1 && column == 2 -> rightMiddle = element
      row == 2 && column == 0 -> leftBottom = element
      row == 2 && column == 1 -> centerBottom = element
      row == 2 && column == 2 -> rightBottom = element
    }
  }
}



