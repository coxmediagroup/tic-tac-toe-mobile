package com.purrprogramming.unbeatabletictactoe

import com.purrprogramming.unbeatabletictactoe.util.TwoDimensionalArray

/**
 *
 * Created by Lance Gleason on 10/19/17 of Polyglot Programming LLC.
 * Web: http://www.polygotprogramminginc.com
 * Twitter: @lgleasain
 * Github: @lgleasain
 *
 */
data class Board(var leftTop: String = "#",
                 var centerTop: String = "#",
                 var rightTop: String = "#",
                 var leftMiddle: String = "#",
                 var centerMiddle: String = "#",
                 var rightMiddle: String = "#",
                 var leftBottom: String = "#",
                 var centerBottom: String = "#",
                 var rightBottom: String = "#",
                 val NUM_ROWS: Int = 3,
                 val NUM_COLUMNS: Int = 3) {

  val cells = TwoDimensionalArray<BoardElement?>(NUM_ROWS, NUM_COLUMNS) { null }

  fun refreshCells() {
    cells[0][0] = BoardElement(0, 0, getBoardElementType(leftTop))
    cells[0][1] = BoardElement(0, 1, getBoardElementType(centerTop))
    cells[0][2] = BoardElement(0, 2, getBoardElementType(rightTop))
    cells[1][0] = BoardElement(1, 0, getBoardElementType(leftMiddle))
    cells[1][1] = BoardElement(1, 1, getBoardElementType(centerMiddle))
    cells[1][2] = BoardElement(1, 2, getBoardElementType(rightMiddle))
    cells[2][0] = BoardElement(2, 0, getBoardElementType(leftBottom))
    cells[2][1] = BoardElement(2, 1, getBoardElementType(centerBottom))
    cells[2][2] = BoardElement(2, 2, getBoardElementType(rightBottom))
  }

  fun getBoardElementType(boardElement: String): BoardElementType {
    when {
      boardElement.equals("X") -> return BoardElementType.X
      boardElement.equals("O") -> return BoardElementType.O
      else -> return BoardElementType.EMPTY
    }
  }

  fun setElementFromCell(row: Int, column: Int, element: BoardElementType) {
    val elementString = element.toString()
    when {
      row == 0 && column == 0 -> leftTop = elementString
      row == 0 && column == 1 -> centerTop = elementString
      row == 0 && column == 2 -> rightTop = elementString
      row == 1 && column == 0 -> leftMiddle = elementString
      row == 1 && column == 1 -> centerMiddle = elementString
      row == 1 && column == 2 -> rightMiddle = elementString
      row == 2 && column == 0 -> leftBottom = elementString
      row == 2 && column == 1 -> centerBottom = elementString
      row == 2 && column == 2 -> rightBottom = elementString
    }
  }
}



