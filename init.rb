require "ruby2d"
require_relative "board"
require_relative "snake"
require_relative "controler"
require_relative "coin_generator"

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

# init controler
controler = Controler.new
controler.extract_positions(snake_instance.snake)

# init coin generator
coint_generator = CoinGenerator.new('./assets/coin.png')

# listen to the keys
on :key_down do |event|
  case event.key
  when 'left'
    controler.is_game_start = true
    controler.x_direction = -50
    controler.y_direction = 0
  when 'right'
    controler.is_game_start = true
    controler.x_direction = 50
    controler.y_direction = 0
  when 'up'
    controler.is_game_start = true
    controler.x_direction = 0
    controler.y_direction = -50
  when 'down'
    controler.is_game_start = true
    controler.x_direction = 0
    controler.y_direction = 50
  end
end

# game speed loop
game_tick = 0
update do
  controler.move(snake_instance.snake) if game_tick % 60 == 0 && controler.is_game_start
  coint_generator.generate(controler.storage) if game_tick % 300 == 0 && controler.is_game_start

  game_tick += 1
end


show