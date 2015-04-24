class GameObject
  attr_reader :aabb

  def initialize window
    @posX = 0
    @posY = 0
    @rotation = 0
    load_assets window
    @aabb = AABB.new
    @aabb.update @posX, @posY, @image.width, @image.height
  end

  def load_assets window
  end

  def update window
    @aabb.update @posX, @posY, @image.width, @image.height
  end

  def draw window
    @aabb.draw window
  end

  # def check_bounds window
  #   if @posY > window.height
  #     @posY = 0
  #   elsif @posY < 0
  #     @posY = window.height
  #   end

  #   if @posX > window.width
  #     @posX = 0
  #   elsif @posX < 0
  #     @posX = window.width
  #   end
  # end
end