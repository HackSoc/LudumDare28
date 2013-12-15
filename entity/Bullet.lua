local class = require 'middleclass.middleclass'
require 'entity.Entity'

Bullet = class('entity.Bullet', Entity)
Bullet.static.sprite = love.graphics.newImage("assets/blue-bullet.png")
Bullet.static.speed = 5
Bullet.static.damage = 10

function Bullet:initialize(id, x, y, collider, dir)
    Entity.initialize(self, id, x, y, self.class.sprite, collider)
    self.dx = self.class.speed * dir
    self.orientation = dir
end

function Bullet:hit(other, dx, dy)
    return true
end
