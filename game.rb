class Game
  attr_accessor :speed, :score, :status, :tick

  def initialize
    @speed = 1
    @score = 0
    @status = "stop"
    @tick = 0

    @grow = Music.new('./assets/grow.mp3')
    @grow.volume = 10

    @game_over = Music.new('./assets/game_over.mp3')
    @game_over.volume = 10
  end

  def refresh_tick
    @tick = 1
  end

  def increase_stats
    refresh_tick
    @speed += 1 unless @speed >= 59
    @score += 1
    grow_song
  end

  def stop
    @status = "stop"
  end

  def start
    @status = "start"
  end

  def grow_song
    @grow.play
  end

  def game_over_song
    @game_over.play
  end
end