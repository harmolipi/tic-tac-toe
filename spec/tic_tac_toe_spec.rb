# frozen_string_literal: true

require_relative '../lib/tic_tac_toe'
require_relative '../lib/player'

describe TicTacToe do
  let(:player) { instance_double(Player) }
  subject(:my_game) { described_class.New(player.New('X', 1), play.New('O', 2)) }
  describe '#initialize' do
    # player_one = Player.new('X', 1)
    # player_two = Player.new('O', 2)

    context 'when creating a new game' do
      it 'sets board_hash to the correct value' do
        expect(my_game.board_hash).to eql({"1"=>"0,0", "2"=>"0,1", "3"=>"0,2", "4"=>"1,0", "5"=>"1,1", "6"=>"1,2", "7"=>"2,0", "8"=>"2,1", "9"=>"2,2"})
      end
    end
  end
end
