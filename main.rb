require 'gosu'
require_relative 'player'
require_relative 'asteroid'

class MyWindow < Gosu::Window
  def initialize
   super(640, 480, false)
   self.caption = 'Hello World!'

   @player = Player.new self
   @asteroids = []
   @cursor = Gosu::Image.new(self, 'assets/cursor.png')


   #load dat shit
   load_assets
  end

  private

  def load_assets 
    @bg = Gosu::Image.new(self, File.expand_path("assets/bg.jpg"), true)
  end


  def update
    if rand > 0.96 && @asteroids.length < 10
      x = rand * 6
      y = rand * 6
      @asteroids.push Asteroid.new(self, x - 3, y - 3)

    end

    update_asteroids self

    @player.update self

    #collission detection
    detect_collissions
  end

  def draw
    #player rot
    mvecX = self.mouse_x - @player.posX 
    mvecY = self.mouse_y - @player.posY
    mvecLen = Math.sqrt(mvecX*mvecX + mvecY*mvecY)
    mvecXNorm = mvecX / mvecLen
    mvecYNorm = mvecY / mvecLen
    dp = (0*mvecXNorm + (-1)*mvecYNorm)
    cp =  0 * mvecYNorm - -1 * mvecXNorm
    degrees = Math.acos(dp) / Math::PI * 180
    if cp < 0
      degrees *= -1
    end

    @bg.draw(0, 0, 0)
    @player.draw self, degrees
    @asteroids.each{|a|a.draw self}
    @cursor.draw self.mouse_x, self.mouse_y, 0

   
    self.caption = "Hello World! #{@player.health}"
  end

  def update_asteroids window
    @asteroids.each{|a|a.update window}
  end

  def detect_collissions
    @player.projectiles.each do |p|
      @asteroids.each do |a|
        if aabb_colide p, a
          @player.health -= 1
          @player.projectiles.delete p
          @asteroids.delete a
        end
      end
    end
  end

  def aabb_colide rect1, rect2
    (rect1.aabb.x1 < rect2.aabb.x1 + rect2.aabb.width &&
          rect1.aabb.x1 + rect1.aabb.width > rect2.aabb.x1 &&
          rect1.aabb.y1 < rect2.aabb.y1 + rect2.aabb.height &&
          rect1.aabb.height + rect1.aabb.y1 > rect2.aabb.y1)
  end

end

window = MyWindow.new
window.show

