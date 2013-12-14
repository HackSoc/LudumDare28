local class = require 'middleclass.middleclass'
require 'entity.Entity'
require 'entity.Wall'

Ball = class('entity.Ball', Entity)
Ball.static.sprite = love.graphics.newImage("assets/ball.png")
Ball.vx = 2
Ball.vy = -7

function Ball:initialize(x, y, collider)
    Entity.initialize(self, x, y, self.class.sprite, collider)
end

function Ball:update(dt)
    self:move(self.x + self.vx, self.y + self.vy)
end

function Ball:hit(other, dx, dy)
    if other.class == Wall then
        self.vy = -self.vy
    elseif other.class == Paddle then
        self.vx = -self.vx
    end
end
