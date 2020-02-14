class Controler
  attr_accessor :storage, :x_direction, :y_direction

  def initialize(init_store = [])
    @storage = init_store
    @x_direction = 0
    @y_direction = 0
  end

  def extract_positions(snake)
    @storage = snake.map { |i| { pos_x: i.x, pos_y: i.y }}
  end

  def move(snake)
    leading_pice = snake[snake.length - 1]

    new_leading_pos = {
      pos_x: validate(leading_pice.x + @x_direction),
      pos_y: validate(leading_pice.y + @y_direction)
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
        i.x = current_pos[:pos_x]
        i.y = current_pos[:pos_y]
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
