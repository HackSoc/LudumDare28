local class = require 'middleclass.middleclass'
require 'entity.Entity'

Player = class('entity.Player', Entity)
Player.static.sprite = love.graphics.newImage("assets/block.png")
Player.static.speed = 10

function Player:initialize(x, y, collider)
    Entity.initialize(self, x, y, self.class.sprite, collider)
end

function Player:startLeft()
   self.dx = -self.class.speed
end

function Player:startRight()
   self.dx = self.class.speed
end
