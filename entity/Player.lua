local class = require 'middleclass.middleclass'
require 'entity.Mob'

require 'drawable.Drawable'

require 'utils'

local highestiteration = 0

Player = class('entity.Player', Mob)
Player.static.oldsprite = newSprite("assets/character-past.png")
Player.static.sprite = newSprite("assets/character.png")
Player.iteration = 0
Player.deferredDamage = 0

function Player:initialize(id, x, y, collider, orientation)
    Mob.initialize(self, id, x, y, self.class.sprite, collider)
    highestiteration = highestiteration + 1
    self.iteration = highestiteration

    self.orientation = orientation
end

function Player:isCurrentPlayer()
    return highestiteration == self.iteration
end

function Player:damage(amount)
    -- schedule the damage to be applied by "tick"
    self.deferredDamage = self.deferredDamage + amount
end

function Player:draw(vx, vy)
    if self:isCurrentPlayer() then
        self.sprite = self.class.sprite
    else
        self.sprite = self.class.oldsprite
    end

    resetDraw(
        function ()
            local opacity = (5 - highestiteration + self.iteration) / 5
            love.graphics.setColor(255,255,255, 255 * opacity)
            Mob.draw(self, vx, vy)
        end)
end

function Player:tick(state, collider)
    Mob.tick(self, state, collider)
    
    -- apply damage received in Player:damage
    state["health"] = state["health"] or self.maxHealth
    state["health"] = state["health"] - self.deferredDamage
    self.deferredDamage = 0

    -- update instance health so we can draw a health bar
    self.health = state["health"]
end
