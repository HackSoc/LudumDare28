local class = require 'middleclass.middleclass'
require 'entity.Mob'

local highestiteration = 0

Player = class('entity.Player', Mob)
Player.static.oldsprite = love.graphics.newImage("assets/character-1.png")
Player.static.sprite = love.graphics.newImage("assets/character-2.png")
Player.iteration = 0

function Player:initialize(id, x, y, collider)
    Entity.initialize(self, id, x, y, self.class.sprite, collider)
    highestiteration = highestiteration + 1
    self.iteration = highestiteration
    self.dy = 5
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
    local opacity = (5 - highestiteration + self.iteration) / 5
    love.graphics.setColor(255,255,255, 255 * opacity)
    Entity.draw(self)
    love.graphics.setColor(255,255,255,255)
end

function Player:stop()
    Entity.stop(self)
    self.dy = 5
end
