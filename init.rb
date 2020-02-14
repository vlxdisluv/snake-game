require "ruby2d"
require_relative "board"
require_relative "snake"
require_relative "controler"

#set window settings
set({
  :title => "Snake Game",
  :background => 'white',
  :width => 500,
  :height => 500
})

# init board
board_options = {
  :x_size => 10,
  :y_size => 10,
  :shape_size => 50,
  :first_color => "#b49c73",
  :second_color => "#eff0f1",
}
board_instance = Board.new(board_options)
board_instance.draw

# init snake
snake_options = {:length => 5, :size => 50}
snake_instance = Snake.new(snake_options)
snake_instance.draw

# class whitch store history of positions pice of snake
controler = Controler.new
controler.extract_positions(snake_instance.snake)


is_game_start = false
# listener of keypresses
on :key_down do |event|
  case event.key
  when 'left'
    is_game_start = true
    controler.x_direction = -50
    controler.y_direction = 0
  when 'right'
    is_game_start = true
    controler.x_direction = 50
    controler.y_direction = 0
  when 'up'
    is_game_start = true
    controler.x_direction = 0
    controler.y_direction = -50
  when 'down'
    is_game_start = true
    controler.x_direction = 0
    controler.y_direction = 50
  end
end

# infinity loop
tick = 0

update do
  tick += 1
  next unless tick % 60 == 0 && is_game_start
  controler.move(snake_instance.snake)
end

show