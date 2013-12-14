local class = require 'middleclass.middleclass'

Entity = class('entity.Entity')
Entity.id = nil
Entity.x = 0
Entity.y = 0
Entity.width = 0
Entity.height = 0
Entity.sprite = nil
Entity.visible = true
Entity.hitbox = nil
Entity.angle = 0
Entity.orientation = 1
Entity.dx = 0
Entity.dy = 0
Entity.collider = nil

function Entity:initialize(id, x, y, sprite, collider)
    self.id = id
    self.x = x
    self.y = y
    self.width = sprite:getWidth()
    self.height = sprite:getHeight()
    self.sprite = sprite

    self.collider = collider
    self.hitbox = collider:addRectangle(self.id,
                                        self:top(),
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

function Entity:rotate(angle)
    self.angle = angle
    self.hitbox:setRotation(angle)
end

function Entity:draw()
    if self.visible then
        love.graphics.draw(self.sprite, self.x-Display.static.background.drawX, self.y, self.angle, self.orientation, 1, self.width/2, self.height/2)
    end

    x1, y1, x2, y2 = self.hitbox:bbox()
    
    x1 = x1 - Display.static.background.drawX
    x2 = x2 - Display.static.background.drawX
      
    r, g, b, a = love.graphics.getColor()
    love.graphics.setColor(50, 100, 150, 255)
    love.graphics.rectangle("line", x1, y1, x2 - x1, y2 - y1)
    love.graphics.setColor(r, g, b, a)
end

function Entity:tick()
    self:move(self.x + self.dx,
              self.y + self.dy)
end

function Entity:move(x, y)
    self.x = x
    self.y = y
    self.hitbox:moveTo(x, y)
end

function Entity:hit(other, dx, dy)
    return false
end

function Entity:startLeft()
    self.orientation = -1
end

function Entity:startRight()
    self.orientation = 1
end

function Entity:stop()
    self.dx = 0
    self.dy = 0
end
