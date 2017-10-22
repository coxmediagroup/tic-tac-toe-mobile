package com.purrprogramming.unbeatabletictactoe.util

/**
 *
 * Created by Lance Gleason on 10/20/17 of Polyglot Programming LLC.
 * Web: http://www.polygotprogramminginc.com
 * Twitter: @lgleasain
 * Github: @lgleasain
 *
 */
inline fun <reified INNER> TwoDimensionalArray(sizeOuter: Int, sizeInner: Int, noinline innerInit: (Int)->INNER): Array<Array<INNER>>
        = Array(sizeOuter) { Array<INNER>(sizeInner, innerInit) }