require_relative 'board'
# The Game object is responsible for knowing the game mechanics and setup work
class Game
  attr_reader :board
  def initialize(options={})
    # Initialize with an empty board and one droppable block
    @board = Board.new(options)
    @board.add_block
  end

  def run
    # TODO: game mechanic
    true until is_over?
  end

  def is_over?
    # TODO: game mechanic
    false
  end

  def drop_block
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
end
