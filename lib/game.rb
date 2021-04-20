# frozen_string_literal: true

require_relative './tic_tac_toe'
require_relative './player'

player_one = Player.new('X', 1)
player_two = Player.new('O', 2)
TicTacToe.new(player_one, player_two).play
