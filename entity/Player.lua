local class = require 'middleclass.middleclass'
require 'entity.Entity'

local highestiteration = 0

Player = class('entity.Player', Entity)
Player.static.sprite = love.graphics.newImage("assets/character-1.png")
Player.static.speed = 10
Player.iteration = 0

function Player:initialize(x, y, collider)
    Entity.initialize(self, x, y, self.class.sprite, collider)
    highestiteration = highestiteration + 1
    self.iteration = highestiteration
end

function Player:startLeft()
   self.dx = -self.class.speed
end

function Player:startRight()
   self.dx = self.class.speed
end

function Player:draw()
    local opacity = (5 - highestiteration + self.iteration) / 5
    love.graphics.setColor(255,255,255, 255 * opacity)
    Entity.draw(self)
    love.graphics.setColor(255,255,255,255)
end
