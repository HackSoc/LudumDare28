local class = require 'middleclass.middleclass'
require 'entity'
require 'wall'

Ball = class('Ball', Entity)
Ball.vx = 0.5
Ball.vy = -2

function Ball:update(dx)
   self:move(self.x + self.vx, self.y + self.vy)
end

function Ball:hit(other, dx, dy)
   if other.class == Wall then
      self.vy = -self.vy
   end
end
