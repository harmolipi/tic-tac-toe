# frozen_string_literal: true
# rubocop: disable Metrics/BlockLength

require_relative '../lib/tic_tac_toe'
require_relative '../lib/player'

describe TicTacToe do

  # describe '#initialize' do
  #   # player_one = Player.new('X', 1)
  #   # player_two = Player.new('O', 2)

  #   context 'when creating a new game' do
  #     it 'sets board_hash to the correct value' do
  #       board_hash = my_game.instance_variable_get(:@board_hash)
  #       expect(board_hash).to eql({"1"=>"0,0", "2"=>"0,1", "3"=>"0,2", "4"=>"1,0", "5"=>"1,1", "6"=>"1,2", "7"=>"2,0", "8"=>"2,1", "9"=>"2,2"})
  #       # expect(my_game.move)
  #     end
  #   end
  # end

  describe '#player_input' do
    let(:player_one) { instance_double('player', to_s: 'Player 1') }
    let(:player_two) { instance_double('player', to_s: 'Player 2') }
    subject(:my_game) { described_class.new(player_one, player_two) }
    error_message = "\nThat was an invalid move! Please try again."
    error_message2 = "Choose a square,  #{@current_player}: "

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
        invalid_input1 = 'a'
        invalid_input2 = '22'
        valid_input = '6'
        my_game.instance_variable_set(:@current_player, player_one)
        allow(my_game).to receive(:gets).and_return(invalid_input1, invalid_input2, valid_input)
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
end

# rubocop: enable Metrics/BlockLength
