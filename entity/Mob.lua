local class = require 'middleclass.middleclass'
require 'entity.Entity'

Mob = class('entity.Mob', Entity)
Mob.static.speed = 10
Mob.health = 0
Mob.maxHealth = 100

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

function Mob:hit()
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
    if self.dy == 0 then
        self.dy = -30
    end
end

function Mob:draw()
    if self.visible then
        Entity.draw(self)

        local left = self:left() - Display.static.background.viewportX
        local top = self:top()
        local width = self.width
        local height = 10
        
        r, g, b, a = love.graphics.getColor()
        love.graphics.setColor(128, 128, 128, 255)
        love.graphics.rectangle("fill", left, top - height, width, height)

        love.graphics.setColor(255, 0, 0, 255)
        love.graphics.rectangle("fill", left, top - height, width * self.health / self.maxHealth, height)
        love.graphics.setColor(r, g, b, a)
    end
end