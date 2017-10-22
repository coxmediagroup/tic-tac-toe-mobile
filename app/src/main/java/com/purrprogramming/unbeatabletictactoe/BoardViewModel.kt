package com.purrprogramming.unbeatabletictactoe

import android.databinding.BaseObservable
import android.view.View
import com.purrprogramming.unbeatabletictactoe.util.SingleLiveEvent

/**
 *
 * Created by Lance Gleason on 10/20/17 of Polyglot Programming LLC.
 *
 * ViewModel to glue together the model and view with the main functionality of the app.
 *
 * Web: http://www.polygotprogramminginc.com
 * Twitter: @lgleasain
 * Github: @lgleasain
 *
 */
class BoardViewModel(val board: Board = Board()) : BaseObservable() {

  lateinit var playerBoardElementType: BoardElementType
  lateinit var computerBoardElementType: BoardElementType
  var playerBoardCharacter: String = "X"

  val winningPatterns: Array<Int> = arrayOf(
      0b111000000, 0b000111000, 0b000000111, // rows
      0b100100100, 0b010010010, 0b001001001, // cols
      0b100010001, 0b001010100)               // diagonals

  val gameOverEvent = SingleLiveEvent<GameState>()

  val minMaxAiPlayer = MinMaxAIPlayer(board)

  var currentGameState = GameState.PLAYING

  /**
   * bound the the onclick event of all cells on the board. This kicks everything else off.
   */
  fun selectSquare(view: View) {
    when {
      view.id == R.id.squareTopLeft -> board.leftTop = getBoardCharacterToSet(board.leftTop)
      view.id == R.id.squareTopCenter -> board.centerTop = getBoardCharacterToSet(board.centerTop)
      view.id == R.id.squareTopRight -> board.rightTop = getBoardCharacterToSet(board.rightTop)
      view.id == R.id.squareMidLeft -> board.leftMiddle = getBoardCharacterToSet(board.leftMiddle)
      view.id == R.id.squareMidCenter -> board.centerMiddle = getBoardCharacterToSet(board.centerMiddle)
      view.id == R.id.squareMidRight -> board.rightMiddle = getBoardCharacterToSet(board.rightMiddle)
      view.id == R.id.squareBottomLeft -> board.leftBottom = getBoardCharacterToSet(board.leftBottom)
      view.id == R.id.squareBottomCenter -> board.centerBottom = getBoardCharacterToSet(board.centerBottom)
      view.id == R.id.squareBottomRight -> board.rightBottom = getBoardCharacterToSet(board.rightBottom)
    }

    notifyChange()

    if (isGameOver(playerBoardElementType)) {
      val move = minMaxAiPlayer.move()
      board.setElementFromCell(move!![0], move[1], computerBoardElementType)
      notifyChange()
      isGameOver(computerBoardElementType)
    }
  }

  /**
   * helper method to either return the current players value or the the current value of the
   * square on a click.
   */
  fun getBoardCharacterToSet(currentValue: String): String {
    if (currentValue.equals("#")) {
      return playerBoardCharacter
    } else {
      return currentValue
    }
  }

  /**
   * used to select which side the player will be using when starting the game.
   */
  fun selectPlayer(playerBoardElementType: BoardElementType) {
    this.playerBoardElementType = playerBoardElementType
    minMaxAiPlayer.setBoardElementType(playerBoardElementType)

    if (playerBoardElementType == BoardElementType.O) {
      this.playerBoardCharacter = "O"
      this.computerBoardElementType = BoardElementType.X
    } else {
      this.playerBoardCharacter = "X"
      this.computerBoardElementType = BoardElementType.O
    }
  }

  /**
   * determines if the game has been won or is a draw.
   */
  fun isGameOver(player: BoardElementType): Boolean {
    board.refreshCells()
    if (hasWon(player)) {
      currentGameState = when (player) {
        BoardElementType.X -> GameState.X_WON
        else -> GameState.O_WON
      }
      gameOverEvent.value = currentGameState
    } else if (isDraw()) {
      currentGameState = GameState.DRAW
      gameOverEvent.value = currentGameState
    } else {
      return true
    }
    return false
  }

  fun isDraw(): Boolean {
    for (row in 0 until board.NUM_ROWS) {
      (0 until board.NUM_COLUMNS)
          .filter { board.cells[row][it]?.content == BoardElementType.EMPTY }
          .forEach { return false }
    }
    return true
  }

  fun hasWon(thePlayer: BoardElementType): Boolean {
    var pattern = 0b000000000
    for (row in 0 until board.NUM_ROWS) {
      (0 until board.NUM_COLUMNS)
          .asSequence()
          .filter { board.cells[row][it]?.content == thePlayer }
          .forEach { pattern = pattern or (1 shl (row * board.NUM_COLUMNS + it)) }
    }

    winningPatterns
        .asSequence()
        .filter { (pattern and it) == it }
        .forEach { return true }

    return false
  }

}