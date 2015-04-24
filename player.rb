require_relative 'projectile'
require_relative 'aabb'
require_relative 'game_object'

class Player < GameObject
  attr_reader :posX
  attr_reader :posY

  def initialize window
    super(window)
    load_assets window
    @projectiles = []
    @shot_delay = 0

  end

  def load_assets window
    @image = Gosu::Image.new(window, File.expand_path("assets/dbutt.png"), true)
  end

  def update window
    super(window)
    handle_input window
    check_bounds window
    @projectiles.each{|p|p.update window}

    if @shot_delay > 0
      @shot_delay -= 1
    end

    #collission detection
    detect_collissions
  end

  def detect_collissions
    #projectiles over asteroids
    #asteroids over player
#     if (rect1.x < rect2.x + rect2.width &&
#    rect1.x + rect1.width > rect2.x &&
#    rect1.y < rect2.y + rect2.height &&
#    rect1.height + rect1.y > rect2.y) {
#     // collision detected!
# }
    @projectiles.each do |p|
      #if p.aabb.x1 
    end
  end


  def draw window, rotation
    super(window)
    @rotation = rotation
    @image.draw_rot(@posX, @posY, 0, @rotation)
    @projectiles.delete_if{|p|p.life < 0}
    @projectiles.each{|p|p.draw window}
  end

  private

  def handle_input window
    if window.button_down?(Gosu::KbS)
      @posY+=4
    end

    if window.button_down?(Gosu::KbW)
      @posY-=4
    end

    if window.button_down?(Gosu::KbA)
      @posX-=4
    end

    if window.button_down?(Gosu::KbD)
      @posX+=4
    end

    if window.button_down?(Gosu::KbSpace)
      shoot_projectile window
    end
  end

  private

  def shoot_projectile window
    return false if @shot_delay > 0 
    @projectiles.push Projectile.new window, @posX, @posY, @rotation
    @shot_delay = 0
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