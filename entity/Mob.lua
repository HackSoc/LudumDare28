local class = require 'middleclass.middleclass'
require 'entity.Entity'

Mob = class('entity.Mob', Entity)
Mob.static.speed = 10
Mob.health = 100

function Mob:startLeft()
    Entity.startLeft(self)
    self.dx = -self.class.speed
end

function Mob:startRight()
    Entity.startRight(self)
    self.dx = self.class.speed
end

function Mob:damage(amount)
    self.health = self.health - amount
end

function Mob:hit()
    return self.health <= 0
end

function Mob:tick()
    Entity.tick(self)
    self.dy = self.dy + 1
    if self.dy > 5 then
        self.dy = 5
    end
end
