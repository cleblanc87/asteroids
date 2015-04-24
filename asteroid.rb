require_relative 'aabb'
require_relative 'game_object'

class Asteroid < GameObject

  def initialize window, velX, velY
    super(window)
    load_assets window
    @velX = velX
    @velY = velY
    @health = 2
  end

  def load_assets window
    @image = Gosu::Image.new(window, File.expand_path("assets/asteroid.png"), false)
  end

  def update window
    super(window)
    @posX += @velX
    @posY += @velY
    check_bounds window
  end

  def draw window
    super(window)
    @image.draw_rot(@posX, @posY, 0, 0)
  end

  def check_bounds window
    if @posY > window.height
      @posY = 0
    elsif @posY < 0
      @posY = window.height
    end

    if @posX > window.width
      @posX = 0
    elsif @posX < 0
      @posX = window.width
    end
  end
end