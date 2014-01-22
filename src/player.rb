require_relative 'game'

class Player
  attr_reader :name
  def initialize(name)
    @name = name
    @game = nil
  end

  def initiate_game(options={})
    @game = Game.new(options)
  end

  def play_game
    # If the player does not initiate game, it is automatically invoked w/ default options
    initiate_game unless @game

    10.times do
      move = possible_moves.sample
      rand(5).times do
        @game.send(move)
      end
      @game.drop_block
      @game.render
      sleep(1)
    end
  end

  private
  def possible_moves
    [:move_block_left, :move_block_right]
  end
end
