local class = require 'middleclass.middleclass'

require 'entity.entity'

Bullet = class('entity.Bullet', Entity)
Bullet.static.speed = 20
Bullet.static.damage = 10

function Bullet:initialize(id, x, y, sprite, collider, dir)
    Entity.initialize(self, id, x, y, sprite, collider)
    self.dx = self.class.speed * dir
    self.orientation = dir
end

function Bullet:hit(other, dx, dy)
    return true
end
