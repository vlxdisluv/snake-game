class Snake
  attr_reader :snake

  def initialize(options = {:length => 3, :size => 50})
    @snake = [];
    @snake_length = options[:length]
    @options = {
      size: options[:size],
      color: 'green'
    }
  end

  def draw
    @snake_length.times do |i|
      @options[:x] = normalize(i)
      @options[:y] = normalize(0)

      pice =  Square.new(@options)

      push_pice(pice)
    end
  end

  def increase_snake
    @options[:x] = @snake[0].x
    @options[:y] = @snake[0].y

    pice = Square.new(@options)

    @snake.unshift(pice)
  end

  def push_pice(pice)
    @snake << pice
  end

  def normalize(value)
    value * 50
  end
end