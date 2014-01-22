require_relative 'src/player'

puts "Initiating..."
player = Player.new('Fei')
player.initiate_game(max_width: 8, max_height: 20)
player.play_game
puts "Game finished."
