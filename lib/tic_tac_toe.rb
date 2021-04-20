# frozen_string_literal: true

# rubocop: disable Metrics/ClassLength
# rubocop: disable Metrics/MethodLength
# rubocop: disable Metrics/AbcSize

require_relative './player'
require 'pry'

# Tic-Tac-Toe game class
class TicTacToe
  attr_reader :board

  DIAGONAL_ONE = ['0,0', '1,1', '2,2'].freeze
  DIAGONAL_TWO = ['0,2', '1,1', '2,0'].freeze
  COLUMN_DIVIDER = '|'
  ROW_DIVIDER = '---|---|---'

  def initialize(player_one, player_two)
    @board = [['1', '2', '3'],
              ['4', '5', '6'],
              ['7', '8', '9']]
    @board_hash = {}
    init_board_hash
    @move = ''
    @current_player = player_one
    @next_player = player_two
    @past_moves = []
    @winner = nil
  end

  def init_board_hash
    @board.each_with_index do |inner_array, index1|
      inner_array.each_with_index do |cell_number, index2|
        @board_hash[cell_number] = "#{index1},#{index2}"
      end
    end
  end

  # def print_board_hash
  #   p @board_hash
  # end

  def play
    game_loop
    print_board
    puts ending
  end

  def game_loop
    9.times do
      print_board
      print "Choose a square, #{@current_player}: "
      @move = player_input
      print "\n"
      place_marker(@move)
      if game_over?
        @winner = @current_player
        break
      end
      @current_player, @next_player = @next_player, @current_player
    end
  end

  def player_input
    loop do
      user_input = gets.chomp
      return user_input if valid_move(user_input)

      input_error
    end
  end

  def input_error
    puts "\nThat was an invalid move! Please try again."
    print_board
    print "Choose a square,  #{@current_player}: "
  end

  def ending
    @winner.nil? ? "It's a tie!" : "#{@winner} won!"
  end

  def print_row(num)
    board[num].map { |x| x.center(3) }.join(COLUMN_DIVIDER)
  end

  def print_board
    row_array = []
    3.times { |i| row_array << print_row(i) }
    puts "\n#{row_array.join("\n#{ROW_DIVIDER}\n")}\n\n"
  end

  def place_marker(cell)
    binding.pry
    return if cell_not_empty(cell)

    coordinates = get_coordinates(cell)
    board[coordinates[0]][coordinates[1]] = @current_player.game_piece
    @past_moves.push(cell)
    update_cell_counts(coordinates, cell)
  end

  def update_cell_counts(coordinates, cell)
    @current_player.player_cell_counts["column #{coordinates[0]}"] += 1
    @current_player.player_cell_counts["row #{coordinates[1]}"] += 1
    @current_player.player_cells << @board_hash[cell]
  end

  def get_coordinates(cell)
    @board_hash[cell].split(',').map(&:to_i)
  end

  def get_marker(cell)
    coordinates = get_coordinates(cell)
    board[coordinates[0]][coordinates[1]]
  end

  def cell_not_empty(cell)
    get_marker(cell) == @current_player.game_piece || get_marker(cell) == @next_player.game_piece
  end

  def valid_move(move)
    move =~ /^(?!0)\d$/ && !@past_moves.include?(move)
  end

  def diagonals?
    DIAGONAL_ONE.all? { |i| @current_player.player_cells.include? i } ||
      DIAGONAL_TWO.all? { |i| @current_player.player_cells.include? i }
  end

  def game_over?
    diagonals? || @current_player.player_cell_counts.value?(3)
  end
end

# rubocop: enable Metrics/AbcSize
# rubocop: enable Metrics/MethodLength
# rubocop: enable Metrics/ClassLength
