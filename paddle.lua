local class = require 'middleclass.middleclass'
require 'entity'

Paddle = class('Paddle', Entity)
Paddle.static.sprite = love.graphics.newImage("assets/paddle.png")

function Paddle:initialize(x, y, collider)
   Entity.initialize(self, x, y, self.class.sprite, collider)
end

function Paddle:moveUp()
   self:move(self.x, self.y - 5)
end

function Paddle:moveDown()
   self:move(self.x, self.y + 5)
end

function Paddle:hit(other, dx, dy)
   
end
