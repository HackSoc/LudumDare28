local class = require 'middleclass.middleclass'
require 'entity.Entity'

Wall = class('entity.Wall', Entity)

function Wall:initialize(x, y, width, height, collider)
    self.x = x
    self.y = y
    
    self.width = width
    self.height = height

    self.hitbox = collider:addRectangle(self:left(),
                                        self:top(),
                                        self.width,
                                        self.height)
end

function Wall:draw()
    
end

function Wall:hit(other, dx, dy)
    
end
