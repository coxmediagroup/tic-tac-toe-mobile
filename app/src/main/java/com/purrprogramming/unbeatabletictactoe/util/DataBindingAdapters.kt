package com.purrprogramming.unbeatabletictactoe.util

import android.databinding.BindingAdapter
import android.support.v7.widget.AppCompatImageView
import com.purrprogramming.unbeatabletictactoe.BoardElementType
import com.purrprogramming.unbeatabletictactoe.R

/**
 *
 * Created by Lance Gleason on 10/22/17 of Polyglot Programming LLC.
 * Web: http://www.polygotprogramminginc.com
 * Twitter: @lgleasain
 * Github: @lgleasain
 *
 */

object DataBindingAdapters {

  @BindingAdapter("imageResource")
  @JvmStatic
  fun setImageResource(imageView: AppCompatImageView, elementType: BoardElementType) {
    when {
      elementType == BoardElementType.X -> imageView.setImageResource(R.drawable.ic_x)
      elementType == BoardElementType.O -> imageView.setImageResource(R.drawable.ic_o)
      elementType == BoardElementType.EMPTY -> imageView.setImageResource(R.drawable.ic_empty)
    }
  }
}