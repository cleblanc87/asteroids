require_relative 'game_object'

class Projectile < GameObject
  attr_reader :life

  def initialize window, posX, posY, rotation
    super(window)
    @posX = posX
    @posY = posY
    vx = 0
    vy = -1
    @rotation = rotation
    @life = 100

    #theta = deg2rad(angle);
    theta = rotation * Math::PI / 180

    cs = Math.cos(theta);
    sn = Math.sin(theta);

    @velX = (vx * cs - vy * sn) * 5
    @velY = (vx * sn + vy * cs) * 5

    load_assets window
  end

  def load_assets window
    @image = Gosu::Image.new(window, File.expand_path("assets/projectile.png"), true)
  end

  def update window
    super(window)
    @posX += @velX
    @posY += @velY
    check_bounds window
    @life -= 1
  end

  def draw window
    super(window)
    @image.draw_rot(@posX, @posY, 0, @rotation)
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