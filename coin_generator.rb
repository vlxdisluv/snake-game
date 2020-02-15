class CoinGenerator
  attr_accessor :storage

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

    coins_pos = storage_to_hash
    combined_storage = snake_storage + coins_pos

    is_matched = combined_storage.find do |i|
      (simplify(i[:x]) == x) && (simplify(i[:y]) == y)
    end

    # @TODO: define count of the empty positions for handling of satck overflow
    return {x: x, y: y} unless is_matched

    random_free_pos(snake_storage)
  end

  def storage_to_hash
    @storage.map { |i| {x: i.x, y: i.y} }
  end

  def remove(eaten_coin)
    @storage = @storage.filter { |i| i.data != eaten_coin.data }
    eaten_coin.remove
  end

  private
    def simplify(value)
      return value / 50
    end

    def normlize(value)
      return value * 50
    end
end