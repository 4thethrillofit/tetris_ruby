require_relative 'board'
# The Game object is responsible for knowing the game mechanics and setup work
class Game
  attr_reader :board
  def initialize(options={})
    # Initialize with an empty board and one droppable block
    @board = Board.new(options)
    @board.add_block
    game_init__messages
  end

  def is_over?
    return false if board.blocks.length == 1

    last_dropped_block = board.blocks[board.blocks.length - 2]

    last_dropped_block.y <= 0 && !last_dropped_block.ready_to_drop
  end

  def drop_block
    # Always que up a new block immediately after the previous block has been dropped
    board.drop_block
    board.add_block
  end

  def move_block_right
    board.move_block_right
  end

  def move_block_left
    board.move_block_left
  end

  def render
    board.render
  end

  private
  def game_init__messages
    puts "Initiating game with width: #{board.max_x}, height: #{board.max_y}"
  end
end
