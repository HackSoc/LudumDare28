local class = require 'middleclass.middleclass'
require 'entity.Entity'
require 'entity.OneBullet'

Asteroid = class('entity.Asteroid', Entity)
Asteroid.static.sprite = love.graphics.newImage("assets/asteroid-1.png")
Asteroid.static.dx = 0
Asteroid.static.dy = 0

function Asteroid:initialize(x, y, dx, dy, collider)
   Entity.initialize(self, x, y, self.class.sprite, collider)
   self.dx = dx
   self.dy = dy
end

function Asteroid:update(dt)
   self:move(self.x + self.dx*dt, self.y + self.dy*dt)
end

function Asteroid:hit(other, dx, dy)
   if other.class == Asteroid then
      local averagedx = (abs(self.dx) + abs(other.dx))/2
      local midx = (self.x + other.x)/2
      self.dx = (self.x - midx) / abs(self.x-midx) * averagedx
      other.dx = (other.x - midx) / abs(other.x-midx) * averagedx

      local averagedy = (abs(self.dy) + abs(other.dy))/2
      local midy = (self.y + other.y)/2
      self.dy = (self.y - midy) / abs(self.y-midy) * averagedy
      other.dy = (other.y - midy) / abs(other.y-midy) * averagedy
   elseif other.class == OneBullet then
      self.dead = true
   end
end