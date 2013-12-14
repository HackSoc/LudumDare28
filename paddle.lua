local class = require 'middleclass.middleclass'
require 'entity'

Paddle = class('Paddle', Entity)
Paddle.static.sprite = love.graphics.newImage("paddle.png")

function Paddle:initialize(x, y, collider)
   Entity.initialize(self, x, y, self.class.sprite, collider)
end

function Paddle:hit(other, dx, dy)
   
end
