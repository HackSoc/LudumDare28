local class = require 'middleclass.middleclass'
require 'entity'
require 'wall'

Ball = class('Ball', Entity)
Ball.vx = 2
Ball.vy = -7

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
