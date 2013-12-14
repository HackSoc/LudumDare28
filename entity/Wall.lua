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
    if other.x < 0 then
        other:move(800, other.y)
    elseif other.x > 800 then
        other:move(0, other.y)
    end
    if other.y < 0 then
        other:move(other.x, 600)
    elseif other.y > 600 then
        other:move(other.x, 0)
    end
end