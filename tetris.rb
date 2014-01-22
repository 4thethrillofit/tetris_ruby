require_relative 'src/player'

player = Player.new('Fei')
player.initiate_game(max_width: 8, max_height: 20)
player.play_game
