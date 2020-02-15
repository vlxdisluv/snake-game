class CoinGenerator
  def initialize(path)
    @storage = []

    @path = path
    @options = {
      clip_width: 50,
      time: 300,
      loop: true,
    }
  end

  def generate(snake_storage)
    free_pos = random_free_pos(snake_storage)

    @options[:x] = normlize(free_pos[:x])
    @options[:y] = normlize(free_pos[:y])

    @coin = Sprite.new(
      @path,
      @options,
    )
    @coin.play

    @storage << @coin
  end

  def random_free_pos(snake_storage)
    x = rand(10)
    y = rand(10)

    convert_storage = @storage.map { |i| {x: i.x, y: i.y} }
    combined_storege = snake_storage + convert_storage

    matches = combined_storege.find do |i|
      (simplify(i[:x]) == x) && (simplify(i[:y]) == y)
    end

    # @TODO: define count of the empty positions for handling of satck overflow

    return random_free_pos(snake_storage) if matches

    return {x: x, y: y}
  end

  private
    def simplify(value)
      return value / 50
    end

    def normlize(value)
      return value * 50
    end
end