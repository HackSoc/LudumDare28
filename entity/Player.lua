local class = require 'middleclass.middleclass'
require 'entity.Entity'

local highestiteration = 0

Player = class('entity.Player', Entity)
Player.static.oldsprite = love.graphics.newImage("assets/character-1.png")
Player.static.sprite = love.graphics.newImage("assets/character-2.png")
Player.static.speed = 10
Player.iteration = 0
Player.health = 100

function Player:initialize(id, x, y, collider)
    Entity.initialize(self, id, x, y, self.class.sprite, collider)
    highestiteration = highestiteration + 1
    self.iteration = highestiteration
end

function Player:startLeft()
    Entity.startLeft(self)
    self.dx = -self.class.speed
end

function Player:startRight()
    Entity.startRight(self)
    self.dx = self.class.speed
end

function Player:draw()
    if highestiteration == self.iteration then
        self.sprite = self.class.sprite
    else
        self.sprite = self.class.oldsprite
    end
    local opacity = (5 - highestiteration + self.iteration) / 5
    love.graphics.setColor(255,255,255, 255 * opacity)
    Entity.draw(self)
    love.graphics.setColor(255,255,255,255)
end

function Player:damage(amount)
    self.health = self.health - amount
    self.dead = self.health < 0

    if self.dead then
        print("I'm dead!")
    end
end
