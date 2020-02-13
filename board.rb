class Board
  def initialize(options)
    @x_size = options[:x_size]
    @y_size = options[:y_size]
    @first_color = options[:first_color]
    @second_color = options[:second_color]
    @shape_size = options[:shape_size]
  end

  def draw
    @x_size.times do |x|
      @y_size.times do |y|
        color = (x + y).even? ? @first_color : @second_color

        Square.new(
          x: x * @shape_size,
          y: y * @shape_size,
          size: @shape_size,
          color: color,
        );
      end
    end
  end
end