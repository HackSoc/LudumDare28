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
    self.dy = self.dy + 4
    if self.dy > 10 then
        self.dy = 10
    end
end

function Mob:jump()
    if self.dy == 0 then
        self.dy = -30
    end
end
