local class = require 'middleclass.middleclass'
require 'entity.Entity'
require 'entity.Tile'
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
    if (other.class == Tile and self.y < other.y and self.x > other.x - other.width / 2 and self.x < other.x + other.width / 2) then
        self.canJump = true
    end
    
    return self.health <= 0
end

function Mob:tick(state, collider)
    Entity.tick(self, state)
    self.dy = self.dy + 4
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

function Mob:draw()
    Entity.draw(self)
    local healthBarHeight = 7
    local healthBarOffset = 5
    local healthBarWidth = self.width * 2

    if self.health ~= 0 then
        drawFilledBar(self:left() - (healthBarWidth-self.width)/2 - Display.static.background.viewportX,
                      self:top() - healthBarHeight - healthBarOffset,
                      healthBarWidth,
                      healthBarHeight,
                      self.health / self.maxHealth,
                      {255, 0, 0, 255},
                      {128, 128, 128, 255})
    end
end
