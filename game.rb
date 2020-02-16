class Game
  attr_accessor :speed, :score, :status, :tick

  def initialize
    @speed = 1
    @score = 0
    @status = "stop"
    @tick = 0
  end

  def refresh_tick
    @tick = 0
  end

  def increase_stats
    refresh_tick
    @speed += 1 unless @speed >= 59
    @score += 1
  end
end