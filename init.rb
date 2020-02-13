require "ruby2d"
require_relative "board"
require_relative "snake"

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
class Controls
  def initialize(shape_chain)
    @shape_chain = shape_chain
    @controls = nil
  end

  attr_accessor :controls

  def move(newControls)
    @controls.shift
    @controls.push newControls
    @controls
  end

  def poss_shapes()
    @controls = @shape_chain.map do |i|
      {:poss_x => i.x, :poss_y => i.y}
    end
  end
end

controls = Controls.new(snake_instance.snake)
controls.poss_shapes

@x_speed = 0
@y_speed = 0

tick = 0

is_game_start = false


# listener of keypresses
on :key_down do |event|
  case event.key
  when 'left'
    is_game_start = true
    @x_speed = -50
    @y_speed = 0
  when 'right'
    is_game_start = true
    @x_speed = 50
    @y_speed = 0
  when 'up'
    is_game_start = true
    @x_speed = 0
    @y_speed = -50
  when 'down'
    is_game_start = true
    @x_speed = 0
    @y_speed = 50
  end
end


def validatePlace(poss)
  if poss > 450
    0
  elsif poss < 0
    450
  else
    poss
  end
end

# infinity loop
update do
  tick += 1
  next unless tick % 60 == 0 && is_game_start
  # snake_instance.snake
  leadShape = snake_instance.snake[snake_instance.snake.length - 1]
  controls.move({
    :poss_x => validatePlace(leadShape.x + @x_speed),
    :poss_y => validatePlace(leadShape.y + @y_speed)
  })

  snake_instance.snake.each_with_index do |i, x|
    pp controls.controls[x][:poss_y]
    i.x = controls.controls[x][:poss_x]
    i.y = controls.controls[x][:poss_y]
  end
end

show