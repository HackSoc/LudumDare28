local class = require 'middleclass.middleclass'

require 'entity.entity'
require 'entity.tile'
require 'utils'

Mob = class('entity.Mob', Entity)
Mob.static.speed = 10
Mob.health = 0
Mob.maxHealth = 100
Mob.canJump = false

function Mob:initialize(...)
    Entity.initialize(self, ...)
    self.health = self.maxHealth
end

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

function Mob:hit(other, dx, dy)
    if (other:isInstanceOf(Tile) and self.y < other.y and self.x > other.x - other.width / 2 and self.x < other.x + other.width / 2) then
        self.canJump = true
    end
    
    -- we can only die on encountering bullets
    -- this should not be necessary, but seems to be :(
    if other:isInstanceOf(Bullet) then
        return self.health <= 0
    else
        return false
    end
end

function Mob:tick(state, collider)
    Entity.tick(self, state)
    self.dy = self.dy + 3 * constants.speed
    if self.dy > 10 then
        self.dy = 10
    end
end

function Mob:jump()
    if self.canJump then
        self.dy = -30
        self.canJump = false
    end
end
