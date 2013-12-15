local class = require 'middleclass.middleclass'
require 'entity.Mob'

require 'drawable.Drawable'

require 'utils'

local highestiteration = 0

Player = class('entity.Player', Mob)
Player.static.oldsprite = newSprite("assets/character-1.png")
Player.static.sprite = newSprite("assets/character-2.png")
Player.iteration = 0

function Player:initialize(id, x, y, collider, orientation)
    Mob.initialize(self, id, x, y, self.class.sprite, collider)
    highestiteration = highestiteration + 1
    self.iteration = highestiteration

    self.orientation = orientation
    self.sprite.orientation = orientation
end

function Player:isCurrentPlayer()
    return highestiteration == self.iteration
end

function Player:draw()
    if self:isCurrentPlayer() then
        self.sprite = self.class.sprite
        Display.static.background:panX(self.x)
    else
        self.sprite = self.class.oldsprite
    end
    resetDraw(
        function ()
            local opacity = (5 - highestiteration + self.iteration) / 5
            love.graphics.setColor(255,255,255, 255 * opacity)
            Mob.draw(self)
        end)
end
