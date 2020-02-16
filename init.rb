require "ruby2d"
require_relative "game"
require_relative "board"
require_relative "snake"
require_relative "controler"
require_relative "coin_generator"

game = Game.new
#set window settings
set({
  title: "Snake Game",
  background: 'white',
  width: 500,
  height: 500
})

# init board
board_options = {
  x_size: 10,
  y_size: 10,
  shape_size: 50,
  first_color: "#b49c73",
  second_color: "#eff0f1",
}
board_instance = Board.new(board_options)
board_instance.draw

# init snake
snake_instance = Snake.new(length: 3, size: 50)
snake_instance.draw

# init coin generator
coin_generator = CoinGenerator.new('./assets/coin.png')

# init controler
controler = Controler.new
controler.extract_positions(snake_instance.snake)


# listen to the keys
on :key_down do |event|
  game.status = 'start' unless game.status = 'start'

  case event.key
  when 'escape'
    game.status = 'stop'
  when 'left'
    controler.x_direction = -50
    controler.y_direction = 0
  when 'right'
    controler.x_direction = 50
    controler.y_direction = 0
  when 'up'
    controler.x_direction = 0
    controler.y_direction = -50
  when 'down'
    controler.x_direction = 0
    controler.y_direction = 50
  end
end

# game loop
update do
  controler.move(snake_instance, coin_generator, game) if game.tick % (60 - game.speed) == 0 && game.status == "start"
  coin_generator.generate(controler.storage) if game.tick % 300 == 0 && game.status == "start"

  game.tick += 1
end

show