package com.purrprogramming.unbeatabletictactoe.activities

import android.content.Intent
import android.databinding.DataBindingUtil
import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import com.purrprogramming.unbeatabletictactoe.R
import com.purrprogramming.unbeatabletictactoe.databinding.ActivityGameChoiceBinding
import com.purrprogramming.unbeatabletictactoe.BoardElementType

class GameChoiceActivity : AppCompatActivity() {

  lateinit var binding: ActivityGameChoiceBinding

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    binding = DataBindingUtil.setContentView(this, R.layout.activity_game_choice)

    val intent = Intent(this, BoardActivity::class.java)

    binding.oButton.setOnClickListener {
      intent.putExtra("side", BoardElementType.O.ordinal)
      startActivity(intent)
    }

    binding.xButton.setOnClickListener {
      intent.putExtra("side", BoardElementType.X.ordinal)
      startActivity(intent)
    }

  }

}
