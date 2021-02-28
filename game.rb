class Game
  WIN_CONDITIONS = [[0, 0], [1, 0], [2, 0],
                    [0, 1], [1, 1], [2, 1],
                    [0, 2], [1, 2], [2, 2],
                    [0, 0], [0, 1], [0, 2],
                    [1, 0], [1, 1], [1, 2],
                    [2, 0], [2, 1], [2, 2],
                    [0, 0], [1, 1], [2, 2],
                    [0, 2], [1, 1], [2, 0]]
  COLUMN_DIVIDER = "|"
  ROW_DIVIDER = "---|---|---"
                    # think I can simplify the win conditions...
                    # win if all three have the same number in the first
                    # or second value, or if it's one of the 2 diagonal options
  attr_reader :board
  
  def initialize(player_one, player_two)
    @board = [['1', '2', '3'], 
              ['4', '5', '6'],
              ['7', '8', '9']]
    
    @board_hash = {}

    @board.each_with_index do |inner_array, index1|
      inner_array.each_with_index do |cell_number, index2|
        @board_hash[cell_number] = "#{index1},#{index2}"
      end
    end

    # puts @board_hash

    # @board_hash = {1 => [0][0], 2 => [0][1]}
    @move = ""
    @current_player = player_one
    @next_player = player_two
    @winner
    @won = false
  end

  def play
    until @won
      print_board
      print 'Choose a square: '
      @move = gets.chomp
      if invalid_move
      print "\n"
      place_marker(@move, @current_player.game_piece)
      break if game_over?
      @current_player, @next_player = @next_player, @current_player
    end
    print_board
    puts "#{@winner} won!"
  end

  def print_row(num)
    board[num].map { |x| x.center(3) }.join(COLUMN_DIVIDER)
  end

  def print_board
    # puts board[0].join(COLUMN_DIVIDER)
    # puts ROW_DIVIDER
    # puts board[1].join(COLUMN_DIVIDER)
    # puts ROW_DIVIDER
    # puts board[2].join(COLUMN_DIVIDER)

    row_array = []
    x = 0

    print "\n"

    while x < 3
      row_array << print_row(x)
      x += 1
    end

    puts row_array.join("\n#{ROW_DIVIDER}\n")

    print "\n"

  end

  def place_marker(cell, marker)
    unless cell_not_empty(cell)
      coordinates = @board_hash[cell].split(',')
      # puts "Coordinates are #{coordinates}"
      @current_player.player_cells << coordinates
      # puts "Player #{@current_player.player_num}: #{@current_player.player_cells}"
      board[coordinates[0].to_i][coordinates[1].to_i] = marker

      unless @current_player.player_cell_counts["column #{coordinates[0]}"] == nil
        @current_player.player_cell_counts["column #{coordinates[0]}"] += 1
      else
        @current_player.player_cell_counts["column #{coordinates[0]}"] = 1
      end

      unless @current_player.player_cell_counts["row #{coordinates[1]}"] == nil
        @current_player.player_cell_counts["row #{coordinates[1]}"] += 1
      else
        @current_player.player_cell_counts["row #{coordinates[1]}"] = 1
      end

      # puts "Player #{@current_player.player_num} cell count: #{@current_player.player_cell_counts}"
    end
  end

  def get_marker(cell)
    coordinates = @board_hash[cell].split(',')
    board[coordinates[0].to_i][coordinates[1].to_i]
  end

  def cell_not_empty(cell)
    get_marker(cell) == @current_player.game_piece || get_marker(cell) == @next_player.game_piece
  end

  def game_over?
    if @current_player.player_cell_counts.value?(3)
      @winner = @current_player
      true
    else
      false
    end
  end
end
