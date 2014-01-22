class Block
  attr_accessor :x, :y, :ready_to_drop
  def initialize(max_x)
    @x = max_x / 2 - 1
    @y = 0
    @ready_to_drop = true
  end
end
