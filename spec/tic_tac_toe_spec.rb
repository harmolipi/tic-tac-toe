# frozen_string_literal: true

# rubocop: disable Metrics/BlockLength

require_relative '../lib/tic_tac_toe'
require_relative '../lib/player'

describe TicTacToe do
  let(:player_one) { instance_double('player', to_s: 'Player 1', game_piece: 'X', player_cell_counts: Hash.new { 0 }, player_cells: []) }
  let(:player_two) { instance_double('player', to_s: 'Player 2', game_piece: 'Y', player_cell_counts: Hash.new { 0 }, player_cells: []) }

  describe '#initialize' do
    subject(:my_game) { described_class.new(player_one, player_two) }

    context 'when creating a new game' do
      it 'sets board_hash to the correct value' do
        board_hash = my_game.instance_variable_get(:@board_hash)
        expect(board_hash).to eql({ '1' => '0,0', '2' => '0,1', '3' => '0,2',
                                    '4' => '1,0', '5' => '1,1', '6' => '1,2',
                                    '7' => '2,0', '8' => '2,1', '9' => '2,2' })
      end
    end
  end

  describe '#player_input' do
    subject(:my_game) { described_class.new(player_one, player_two) }

    context 'when player input is valid' do
      before do
        valid_input = '3'
        my_game.instance_variable_set(:@current_player, player_one)
        allow(my_game).to receive(:gets).and_return(valid_input)
      end

      it 'stops loop and does not display error message' do
        expect(my_game).not_to receive(:input_error)
        my_game.player_input
      end
    end

    context 'when user inputs two incorrect values, then a valid input' do
      before do
        letter = 'a'
        invalid_number = '22'
        valid_number = '6'
        my_game.instance_variable_set(:@current_player, player_one)
        allow(my_game).to receive(:gets).and_return(letter, invalid_number, valid_number)
      end

      it 'completes loop and displays error message twice' do
        expect(my_game).to receive(:input_error).twice
        my_game.player_input
      end
    end

    context 'when user inputs a value that has already been played, then a valid input' do
      before do
        invalid_input = '1'
        valid_input = '2'
        my_game.instance_variable_set(:@past_moves, '1')
        allow(my_game).to receive(:gets).and_return(invalid_input, valid_input)
      end

      it 'completes loop and displays error message once' do
        expect(my_game).to receive(:input_error).once
        my_game.player_input
      end
    end
  end

  describe '#game_loop' do
    subject(:my_game) { described_class.new(player_one, player_two) }

    context 'when the game is not won' do
      before do
        # allow(my_game).to receive(:game_over?).and_return(false, false, false, false, false, false, false, false, false)
        allow(my_game).to receive(:game_over?).and_return(false)
        allow(my_game).to receive(:player_input).and_return('1')
        allow(my_game).to receive(:place_marker)
        allow(my_game).to receive(:print_board)
        allow(my_game).to receive(:print)
      end

      it 'loops without stopping' do
        expect(my_game).not_to be_game_over
        my_game.game_loop
      end
    end
  end

  describe '#ending' do
    subject(:my_game) { described_class.new(player_one, player_two) }

    context 'when a player has won' do
      before do
        my_game.instance_variable_set(:@winner, player_one)
      end

      it 'announces the victor' do
        expect(my_game.ending).to eql('Player 1 won!')
      end
    end

    context 'when neither player won' do
      it 'announces the tied game' do
        expect(my_game.ending).to eql("It's a tie!")
      end
    end
  end

  describe 'game_over?' do
    subject(:my_game) { described_class.new(player_one, player_two) }

    context 'when player has the first row' do
      before do
        allow(my_game).to receive(:diagonals?).and_return(false)
      end

      it 'returns true' do
        my_game.place_marker('1')
        my_game.place_marker('2')
        my_game.place_marker('3')
        expect(my_game).to be_game_over
      end
    end

    context 'when player has the second row' do
      before do
        allow(my_game).to receive(:diagonals?).and_return(false)
      end

      it 'returns true' do
        my_game.place_marker('4')
        my_game.place_marker('5')
        my_game.place_marker('6')
        expect(my_game).to be_game_over
      end
    end

    context 'when player has the third row' do
      before do
        allow(my_game).to receive(:diagonals?).and_return(false)
      end

      it 'returns true' do
        my_game.place_marker('7')
        my_game.place_marker('8')
        my_game.place_marker('9')
        expect(my_game).to be_game_over
      end
    end

    context 'when player has first diagonal' do
      it 'returns true' do
        my_game.place_marker('1')
        my_game.place_marker('5')
        my_game.place_marker('9')
        expect(my_game).to be_game_over
      end
    end

    context 'when player has second diagonal' do
      it 'returns true' do
        my_game.place_marker('3')
        my_game.place_marker('5')
        my_game.place_marker('7')
        expect(my_game).to be_game_over
      end
    end
  end
end

# rubocop: enable Metrics/BlockLength
