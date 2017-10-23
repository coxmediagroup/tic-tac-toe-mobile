package com.purrprogramming.unbeatabletictactoe.activities

import android.arch.lifecycle.Observer
import android.content.Intent
import android.databinding.DataBindingUtil
import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.os.Handler
import android.support.design.widget.Snackbar
import android.support.v7.app.AlertDialog
import android.view.Gravity
import android.widget.TextView
import com.purrprogramming.unbeatabletictactoe.BoardViewModel
import com.purrprogramming.unbeatabletictactoe.R
import com.purrprogramming.unbeatabletictactoe.databinding.ActivityBoardBinding
import com.purrprogramming.unbeatabletictactoe.BoardElementType
import com.purrprogramming.unbeatabletictactoe.GameState

/**
 * This is the main activity for the game play.
 */

class BoardActivity : AppCompatActivity() {

  private lateinit var binding: ActivityBoardBinding
  private val boardViewModel = BoardViewModel()
  lateinit var thinkingDialog: AlertDialog

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    binding = DataBindingUtil.setContentView(this, R.layout.activity_board)


    when (intent.extras["side"]) {
      1 -> {
        boardViewModel.selectPlayer(BoardElementType.X)
      }
      2 -> {
        boardViewModel.selectPlayer(BoardElementType.O)
      }

    }

    binding.boardViewModel = boardViewModel
    observeGameStatus()
    observeThinking()
  }

  private fun observeThinking() {

    boardViewModel.thinkingEvent.observe(this@BoardActivity, Observer<Boolean> { thinking ->
      if (thinking!!) {
        binding.executePendingBindings()
        thinkingDialog = AlertDialog.Builder(this).create()
        val thinkingMsg = TextView(this)
        thinkingMsg.gravity = Gravity.CENTER_HORIZONTAL
        thinkingMsg.textSize = resources.getDimension(R.dimen.thinking_size)
        thinkingMsg.text = getText(R.string.thinking)
        thinkingDialog?.setView(thinkingMsg)
        thinkingDialog?.setCancelable(false)
        thinkingDialog.show()
        binding.executePendingBindings()
        Handler().postDelayed({ binding.boardViewModel!!.evaluateGame() }, 500)
      } else {
        thinkingDialog.dismiss()
      }
    })
  }

  private fun observeGameStatus() {
    boardViewModel.gameOverEvent.observe(this@BoardActivity, Observer<GameState> { gameState ->

      var result: String? = null
      var emoji = 0x0
      //
      when (gameState) {
        GameState.DRAW -> {
          result = "It's a draw, play again?"
          Snackbar.make(binding.root, "It's a Draw!", Snackbar.LENGTH_LONG).show()
        }
        GameState.X_WON -> {
          result = "X has won!, play again?"
          emoji = 0x1F60E
          Snackbar.make(binding.root, "x has won!", Snackbar.LENGTH_LONG).show()
        }
        GameState.O_WON -> {
          result = "O has won!, play again?"
          emoji = 0x1F60E
          Snackbar.make(binding.root, "x has won!", Snackbar.LENGTH_LONG).show()
        }
      }

      val restartDialog = AlertDialog.Builder(this).create()
      restartDialog.setCancelable(false)

      val restartText = TextView(this)
      restartText.gravity = Gravity.CENTER_HORIZONTAL
      restartText.textSize = resources.getDimension(R.dimen.emoji_size)
      restartText.text = String(Character.toChars(emoji))

      restartDialog.setView(restartText)
      restartDialog.setTitle(result)
      restartDialog.setButton(AlertDialog.BUTTON_NEGATIVE, "PLAY AGAIN", { dialogInterface, which ->
        val intent = Intent(this, GameChoiceActivity::class.java)
        intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TASK
        startActivity(intent)
      })

      restartDialog.show()

    })

  }


}
