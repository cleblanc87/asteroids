class AABB
  attr_reader :x1, :x2, :x3, :x4, :y1, :y2, :y3, :y4, :height, :width
  def update posX, posY, width, height
    halfWidth = width / 2
    halfHeight = height / 2

    @x1 = posX - halfWidth
    @y1 = posY - halfHeight

    @x2 = posX + halfWidth
    @y2 = posY - halfHeight

    @x3 = posX + halfWidth
    @y3 = posY + halfHeight

    @x4 = posX - halfWidth
    @y4 = posY + halfHeight

    @width = width
    @height = height
  end

  def draw window
    c1 = Gosu::Color.argb(0x22ffffff)
    window.draw_quad(@x1, @y1, c1, @x2, @y2, c1, @x3, @y4, c1, @x4, @y4, c1)
  end

end