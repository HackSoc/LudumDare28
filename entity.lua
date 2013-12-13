local class = require 'middleclass'

require "physics"

Entity = class('Entity')
Entity.static.x = 0
Entity.static.y = 0
Entity.static.width = 0
Entity.static.height = 0
Entity.static.sprite = nil
Entity.static.visible = true
Entity.static.hitbox = nil
Entity.static.dead = false

function Entity:initialize(x, y, sprite, collider)
   self.x = x
   self.y = y
   self.width = sprite:getWidth()
   self.height = sprite:getHeight()
   self.sprite = sprite

   self.hitbox = collider:addRectangle(x,
                                       y,
                                       self.width,
                                       self.height)
end

function Entity:draw()
   if self.visible then
      love.graphics.draw(self.sprite, self.x, self.y)
   end
end

function Entity:update(dx)
   error("Unimplemented")
end

function Entity:move(x, y)
   self.x = x
   self.y = y
   self.hitbox:moveTo(x, y)
end

function Entity:hit(other, dx, dy)
end
