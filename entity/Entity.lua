local class = require 'middleclass.middleclass'

Entity = class('entity.Entity')
Entity.x = 0
Entity.y = 0
Entity.width = 0
Entity.height = 0
Entity.sprite = nil
Entity.visible = true
Entity.hitbox = nil
Entity.dead = false

function Entity:initialize(x, y, sprite, collider)
    self.x = x
    self.y = y
    self.width = sprite:getWidth()
    self.height = sprite:getHeight()
    self.sprite = sprite

    self.hitbox = collider:addRectangle(self:top(),
                                        self:left(),
                                        self.width,
                                        self.height)
end

function Entity:left()
    return self.x - self.width/2
end

function Entity:top()
    return self.y - self.height/2
end

function Entity:draw()
    if self.visible then
        love.graphics.draw(self.sprite, self:left(), self:top())
    end
end

function Entity:update(dt)
    -- error("Unimplemented")
end

function Entity:move(x, y)
    self.x = x
    self.y = y
    self.hitbox:moveTo(x, y)
end

function Entity:hit(other, dx, dy)

end
