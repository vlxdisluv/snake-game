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

  def move(snake)
    leading_pice = snake[snake.length - 1]

    new_leading_pos = {
      x: validate(leading_pice.x + @x_direction),
      y: validate(leading_pice.y + @y_direction)
    }

    update_store(new_leading_pos)
    draw(snake)
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
