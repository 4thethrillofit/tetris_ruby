require 'awesome_print'
require_relative 'block'

class Board
  attr_reader :blocks, :body, :max_x, :max_y
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
    @blocks.last.x -= 1 unless at_left_boundary?
  end

  def move_block_right
    have_block_to_drop?
    @blocks.last.x += 1 unless at_right_boundary?
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
      # Check for special cases when updating
      next if block.ready_to_drop
      if block.y < 0
        @body[0][block.x] = 'X'
        @body[0][block.x+1] = 'X'
        return
      end

      @body[block.y][block.x] = 'X'
      @body[block.y][block.x+1] = 'X'
      @body[block.y+1][block.x] = 'X'
      @body[block.y+1][block.x+1] = 'X'
    end
  end

  def block_under_drop_block?(drop_block, row)
    return false if blocks.length == 1
    row[drop_block.x] || row[drop_block.x+1]
  end

  def have_block_to_drop?
    raise 'No blocks are ready to drop!' unless blocks.last.ready_to_drop
    true
  end

  def drop!(drop_block)
    # Iterate over the body of the board to make sure
    # the iterator steps upon the block most recently stacked
    body.each_with_index do |row, index|
      if block_under_drop_block?(drop_block, row)
        drop_block.y = index - 2
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

  def at_right_boundary?
    blocks.last.x == max_x - 2
  end

  def at_left_boundary?
    blocks.last.x == 0
  end
end
