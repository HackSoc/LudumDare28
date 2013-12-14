local class = require 'middleclass.middleclass'
require 'entity.Entity'

Player = class('entity.Player', Entity)
Player.static.sprite = love.graphics.newImage("assets/ship.png")
Player.static.power = 0.1
Player.vx = 0
Player.vy = 0

function Player:initialize(x, y, collider)
    Entity.initialize(self, x, y, self.class.sprite, collider)
end

function Player:moveUp()
	self.vx = self.vx + math.sin(self.angle) * self.class.power
	self.vy = self.vy - math.cos(self.angle) * self.class.power
end

function Player:moveDown()
    self.vx = self.vx - math.sin(self.angle) * self.class.power
	self.vy = self.vy + math.cos(self.angle) * self.class.power
end

function Player:moveLeft()
    self:rotate(self.angle - math.pi/16)
end

function Player:moveRight()
    self:rotate(self.angle + math.pi/16)
end

function Player:update()
	self.vx = self.vx / 1.01
	self.vy = self.vy / 1.01
	self:move(self.x + self.vx, self.y + self.vy)
end

function Player:hit(other, dx, dy)
	if other.class ~= Wall then
    	error("You lose")
    end
end
