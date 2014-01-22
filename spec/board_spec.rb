require 'spec_helper'
require_relative '../src/board'

describe Board do
  subject(:board) { Board.new }
  describe '#initialize' do
    it "initializes with default width of 8 and height of 20 if no params given" do
      expect(board.body.length).to eq 20
      expect(board.body.first.length).to eq 8
    end

    it "initializes with no blocks" do
      expect(board.blocks).to be_empty
    end

    it "initializes with a max_x reader attr" do
      expect(board.max_x).to eq board.body.first.length
    end

    it "initializes with a max_y reader attr" do
      expect(board.max_y).to eq board.body.length
    end
  end

  describe '#add_block' do
    it "adds a block to #blocks" do
      expect { board.add_block }.to change {
        board.blocks.length
      }.by 1
   end
  end

  describe '#drop_block' do
    before { board.add_block }
    it "does not change the size of #blocks" do
      expect { board.drop_block }.to_not change { board.blocks.length }
    end

    it "changes the y coord of the block" do
      expect { board.drop_block }.to change { board.blocks.last.y }
      block = board.blocks.last
      expect(board.body[block.y][block.x]).to eq 'X'
    end

    it "does not change the y coord of the block to negative" do
      board.drop_block
      expect(board.blocks.last.y).to be > 1
    end

    it "modifies the body of the board" do
      expect { board.drop_block }.to change { board.body }
    end
  end

  describe '#move_block_left' do
    before { board.add_block }
    context 'within boundary' do
      it "changes the x coord of the last block by 1" do
        expect { board.move_block_left }.to change {
          board.blocks.last.x
        }.by(-1)
      end
    end

    context 'out of boundary' do
      it "does not change the x coord beyond the boundary value" do
        width = board.body.first.length
        width.times { board.move_block_left }
        expect(board.blocks.last.x).to eq 0
      end
    end
  end

  describe '#move_block_right' do
    before { board.add_block }
    context 'within boundary' do
      it "changes the x coord of the last block by 1" do
        expect { board.move_block_right }.to change {
          board.blocks.last.x
        }.by(1)
      end
    end

    context 'out of boundary' do
      it "does not change the x coord beyond the boundary value" do
        width = board.body.first.length
        width.times { board.move_block_right }
        expect(board.blocks.last.x).to eq width - 2
      end
    end
  end
end
