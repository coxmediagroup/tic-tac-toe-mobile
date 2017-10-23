package com.purrprogramming.unbeatabletictactoe

/**
 *
 * Created by Lance Gleason on 10/20/17 of Polyglot Programming LLC.
 *
 * data item representing a cell for use in the AI engine.
 *
 * Web: http://www.polygotprogramminginc.com
 * Twitter: @lgleasain
 * Github: @lgleasain
 *
 */
data class BoardElement(val row: Int, val column: Int, var content: BoardElementType = BoardElementType.EMPTY)