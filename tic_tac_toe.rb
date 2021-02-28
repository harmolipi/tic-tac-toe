# Classes: Game, Player
#
# Methods:
  # Board
    # Initialize
    # Play
    # Place_marker
    # Player won?
    # Print board
    # Switch player
    # Current player
    # Get cell
    # set cell
  # Player
    # Select position

require './game'
require './player'



player_one = Player.new('X', 1)
player_two = Player.new('O', 2)
Game.new(player_one, player_two).play
