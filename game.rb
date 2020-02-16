class Game
  attr_accessor :speed, :score, :status, :tick

  def initialize
    @speed = 1
    @score = 0
    @status = "stop"
    @tick = 0

    @song = Music.new('./assets/song.mp3')
    @song.volume = 10
    @song.loop = true
    @song.play
    @song.pause
  end

  def refresh_tick
    @tick = 0
  end

  def increase_stats
    refresh_tick
    @speed += 1 unless @speed >= 59
    @score += 1
  end

  def pause
    @status = "stop"
    @song.pause
  end

  def start
    @status = "start"
    @song.resume
  end
end