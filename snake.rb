class Snake
  attr_reader :snake

  def initialize(options = {:length => 3, :size => 50})
    @snake = [];
    @snake_length = options[:length]
    @snake_size = options[:size]
  end

  def draw
    @snake_length.times do |i|
      pice =  Square.new(
        x: normalize(i),
        y: normalize(0),
        size: @snake_size,
        color: 'green',
      )

      push_pice(pice)
    end
  end

  def push_pice(pice)
    @snake << pice
  end

  def normalize(coord)
    coord * @snake_size
  end
end