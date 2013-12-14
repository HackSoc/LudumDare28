local class = require 'middleclass.middleclass'
require 'entity.Entity'

Player = class('entity.Player', Entity)
Player.static.sprite = love.graphics.newImage("assets/ball.png")

function Player:initialize(x, y, collider)
    Entity.initialize(self, x, y, self.class.sprite, collider)
end

function Player:moveUp()
    self:move(self.x, self.y - 5)
end

function Player:moveDown()
    self:move(self.x, self.y + 5)
end

function Player:moveLeft()
    self:move(self.x - 5, self.y)
end

function Player:moveRight()
    self:move(self.x + 5, self.y)
end

function Player:hit(other, dx, dy)
    error("You lose")
end
