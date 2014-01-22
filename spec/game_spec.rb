require 'spec_helper'
require_relative '../src/game'

describe Game do
  subject(:game) { Game.new }
  describe '#initialize' do
    it "initializes with an empty board" do
      expect(game.board).to be_a Board
      expect(game.board.body).to_not eq 0
      expect(game.board.blocks.length).to eq 1
    end
  end

  # No need to test the other Game methods here since they are just
  # abstraction for the Board object

end
