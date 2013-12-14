local class = require 'middleclass.middleclass'
require 'entity.Entity'
require 'entity.PlayerBullet'

Enemy = class('entity.Enemy', Entity)
Enemy.static.sprite = love.graphics.newImage("assets/character-3.png")
Enemy.static.speed = 5


function Enemy:initialize(id, x, y, collider)
   Entity.initialize(self, id, x, y, self.class.sprite, collider)
   self.dx = -self.class.speed
   self.orientation = -1
end

function Enemy:stop()
end

function Enemy:hit(other, dx, dy)
   --print('Enemy:hit')
   self.x = self.x + dx
   self.y = self.y + dy
   if other.class == PlayerBullet then
      return true
   else
      return false
   end
end

