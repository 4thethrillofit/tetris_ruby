require 'awesome_print'
require_relative 'block'

class Board
  attr_reader :blocks, :body
  def initialize(options={})
    # The board defaults to an 8 * 20 grid
    @max_x = options[:max_width] || defaults[:max_width]
    @max_y = options[:max_height] || defaults[:max_height]
    @body = construct_body
    @blocks = []
  end

  def render
    @body.each { |row| ap row, multiline: false }
    puts "========================================"
  end

  def add_block
    block = Block.new(@max_x)
    @blocks.push(block)
    update!
  end

  def drop_block
    have_block_to_drop?
    drop!(blocks.last)
    update!
  end

  def move_block_left
    have_block_to_drop?
    @blocks.last.x -= 1 unless at_boundary?
  end

  def move_block_right
    have_block_to_drop?
    @blocks.last.x += 1 unless at_boundary?
  end

  private
  def defaults
    {
      max_width: 8,
      max_height: 20
    }
  end

  def construct_body
    Array.new(@max_y) { Array.new(@max_x) }
  end

  def reset_body!
    @body = construct_body
  end

  def update!
    reset_body!
    @blocks.each do |block|
      @body[block.y][block.x] = 'X'
      @body[block.y][block.x+1] = 'X'
      @body[block.y+1][block.x] = 'X'
      @body[block.y+1][block.x+1] = 'X'
    end
  end

  def block_is_under_drop_block?(drop_block, block)
    return false if drop_block == block
    return true if block.x == drop_block.x || block.x+1 == drop_block.x || block.x-1 == drop_block.x
  end

  def have_block_to_drop?
    raise 'No blocks are ready to drop!' unless blocks.last.ready_to_drop
    true
  end

  def drop!(drop_block)
    # We are going to iterate over the blocks array in reverse order to make sure
    # the iterator steps upon the block most recently stacked
    blocks.reverse_each.with_index do |block, index|
      if block_is_under_drop_block?(drop_block, block)
        # IF there is a block UNDER the current block
        # Set the y coord and break out of the block.
        drop_block.y = block.y - 2
        break
      else
        # There is NO block under the current block(we are at the last element)
        # Drop the block to the bottom
        drop_block.y = @body.length - 2
      end
    end

    drop_block.ready_to_drop = false
    @blocks[-1] = drop_block
  end

  def at_boundary?
    return true if blocks.last.x == 0 || blocks.last.x == @body.first.length - 2
    false
  end
end
