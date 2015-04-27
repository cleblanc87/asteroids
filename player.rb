require_relative 'projectile'
require_relative 'aabb'
require_relative 'game_object'

class Player < GameObject
  attr_reader :posX, :posY, :projectiles
  attr_accessor :health
  
  def initialize window
    super(window)
    load_assets window
    @projectiles = []
    @shot_delay = 0
    @health = 100

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
    @shot_delay = 10
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