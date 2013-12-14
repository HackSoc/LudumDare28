local class = require 'middleclass.middleclass'
require 'entity.Entity'

Bullet = class('entity.Bullet', Entity)
Bullet.static.sprite = love.graphics.newImage("assets/blue-bullet.png")
Bullet.static.speed = 0
Bullet.static.damage = 10

function Bullet:initialize(x, y, collider)
    Entity.initialize(self, x, y, self.class.sprite, collider)
    self.dx = self.class.speed
end

function Bullet:stop()
end

function Bullet:hit(other, dx, dy)
    self.dead = true
end
