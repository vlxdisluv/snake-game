class Controler
  attr_accessor :storage, :x_direction, :y_direction, :is_game_start

  def initialize(init_store = [])
    @storage = init_store
    @x_direction = 0
    @y_direction = 0
    @is_game_start = false
  end

  def extract_positions(snake)
    @storage = snake.map { |i| { x: i.x, y: i.y }}
  end

  def move(snake_instance, coin_generator)
    snake = snake_instance.snake
    coins = coin_generator.storage

    leading_pice = snake[snake.length - 1]
    new_leading_pos = {
      x: validate(leading_pice.x + @x_direction),
      y: validate(leading_pice.y + @y_direction)
    }

    eaten_coin = coins.find { |i| i.x == new_leading_pos[:x] && i.y == new_leading_pos[:y] }

    if eaten_coin
      coin_generator.remove(eaten_coin)
      snake_instance.increase_snake
      increase_positions
    end

    update_store(new_leading_pos)
    draw(snake)
  end

  def increase_positions
    x = @storage[0][:x]
    y = @storage[0][:y]

    @storage.unshift({ x: x, y: y})
  end

  private
    def update_store(new_pos)
      @storage.shift
      @storage.push(new_pos)
    end

    def draw(snake)
      snake.each_with_index do |i, x|
        current_pos = @storage[x]
        i.x = current_pos[:x]
        i.y = current_pos[:y]
      end
    end

    def validate(poss)
      if poss > 450
        0
      elsif poss < 0
        450
      else
        poss
      end
    end
end
