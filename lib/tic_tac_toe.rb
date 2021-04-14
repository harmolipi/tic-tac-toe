# frozen_string_literal: true

require_relative './game'
require_relative './player'

player_one = Player.new('X', 1)
player_two = Player.new('O', 2)
Game.new(player_one, player_two).play
