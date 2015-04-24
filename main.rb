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

   
    self.caption = "Hello World! #{degrees} #{cp}"
  end

  def update_asteroids window
    @asteroids.each{|a|a.update window}
  end
end

window = MyWindow.new
window.show

