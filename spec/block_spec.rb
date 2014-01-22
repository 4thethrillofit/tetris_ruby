require 'spec_helper'
require_relative '../src/block'

describe Block do
  let(:max_x) { 8 }
  subject(:block) { Block.new(max_x) }
  describe '#initialize' do
    it "initializes with a y value of 0" do
      expect(block.y).to eq 0
    end

    it "initializes with a x value about half of the x board length" do
      expect(block.x).to eq (max_x / 2 - 1)
    end

    it "initializes with ready_to_drop at true" do
      expect(block.ready_to_drop).to be_true
    end
  end
end
