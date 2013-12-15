local class = require 'middleclass.middleclass'
require 'entity.Mob'

require 'drawable.Drawable'

require 'utils'

local highestiteration = 0

Player = class('entity.Player', Mob)
Player.static.oldsprite = newSprite("assets/character-past.png")
Player.static.sprite = newSprite("assets/character.png")
Player.static.currentHealth = 100
Player.iteration = 0

function Player:initialize(id, x, y, collider, orientation)
    Mob.initialize(self, id, x, y, self.class.sprite, collider)
    highestiteration = highestiteration + 1
    self.iteration = highestiteration

    self.orientation = orientation
    self.health = Player.static.currentHealth
end

function Player:isCurrentPlayer()
    return highestiteration == self.iteration
end

function Player:damage(amount)
    Mob.damage(self,amount)
    if self:isCurrentPlayer() then
       Player.static.currentHealth = self.health 
    end
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
