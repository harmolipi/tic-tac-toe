# frozen_string_literal: true

class Game
  attr_reader :board

  DIAGONAL_ONE = ['0,0', '1,1', '2,2']
  DIAGONAL_TWO = ['0,2', '1,1', '2,0']
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
    @winner = @current_player
  end

  def init_board_hash
    @board.each_with_index do |inner_array, index1|
      inner_array.each_with_index do |cell_number, index2|
        @board_hash[cell_number] = "#{index1},#{index2}"
      end
    end
  end

  def play

    9.times do
      begin
        print_board
        print "Choose a square, #{@current_player}: "
        @move = gets.chomp
        raise if invalid_move(@move)
      rescue StandardError
        puts "\nThat was an invalid move! Please try again."
        retry
      end
      print "\n"
      place_marker(@move, @current_player.game_piece)
      break if game_over?
      @current_player, @next_player = @next_player, @current_player
    end

    print_board

    if @winner != nil
      puts "#{@winner} won!"
    else
      puts "It's a tie!"
    end

  end

  def print_row(num)
    board[num].map { |x| x.center(3) }.join(COLUMN_DIVIDER)
  end

  def print_board
    row_array = []
    print "\n"

    for i in 0...3
      row_array << print_row(i)
    end

    puts row_array.join("\n#{ROW_DIVIDER}\n")
    print "\n"
  end

  def place_marker(cell, marker)
    unless cell_not_empty(cell)
      coordinates = @board_hash[cell].split(',')
      @current_player.player_cells << @board_hash[cell]
      board[coordinates[0].to_i][coordinates[1].to_i] = marker
      @past_moves.push(cell)

      if @current_player.player_cell_counts["column #{coordinates[0]}"].nil?
        @current_player.player_cell_counts["column #{coordinates[0]}"] = 1
      else
        @current_player.player_cell_counts["column #{coordinates[0]}"] += 1
      end

      if @current_player.player_cell_counts["row #{coordinates[1]}"].nil?
        @current_player.player_cell_counts["row #{coordinates[1]}"] = 1
      else
        @current_player.player_cell_counts["row #{coordinates[1]}"] += 1
      end

    end
  end

  def get_marker(cell)
    coordinates = @board_hash[cell].split(',')
    board[coordinates[0].to_i][coordinates[1].to_i]
  end

  def cell_not_empty(cell)
    get_marker(cell) == @current_player.game_piece || get_marker(cell) == @next_player.game_piece
  end

  def invalid_move(move)
    # move is a single digit and has not been played yet
    move !~ /^\d$/ || @past_moves.include?(move)
  end

  def diagonals?
    true if DIAGONAL_ONE.all? { |i| @current_player.player_cells.include? i } ||
            DIAGONAL_TWO.all? { |i| @current_player.player_cells.include? i }
  end

  def game_over?
    if diagonals? || @current_player.player_cell_counts.value?(3)
      @winner = @current_player
      # @won = true
      true
    else
      false
    end
  end

end
