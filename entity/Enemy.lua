local class = require 'middleclass.middleclass'
require 'entity.Mob'

Enemy = class('entity.Enemy', Mob)
Enemy.static.sprite = love.graphics.newImage("assets/character-3.png")
Enemy.static.speed = 5
Enemy.health = 5

function Enemy:initialize(id, x, y, collider)
   Entity.initialize(self, id, x, y, self.class.sprite, collider)
   self:startLeft()
end
