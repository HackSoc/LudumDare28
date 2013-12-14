local class = require 'middleclass.middleclass'
require 'entity.Entity'
require 'entity.Wall'

OneBullet = class('OneBullet', Entity)
OneBullet.static.sprite = love.graphics.newImage("assets/bullet.png")
OneBullet.velocity = 200
OneBullet.steerRate = 4

function OneBullet:initialize(collider)
    print (OneBullet.static.sprite)
    Entity.initialize(self, 200, 200, self.class.sprite, collider)
    self:rotate(math.pi)
end

function OneBullet:update(dt)
    if self.steerLeft then
        self.angle = self.angle - (self.steerRate * dt)
    end
    
    if self.steerRight then
        self.angle = self.angle + (self.steerRate * dt)
    end
    
    if (self.x > 800) then
        self.x = self.x - 800
    end
    
    if (self.y > 600) then
        self.y = self.y - 600
    end
    
    self:move(self.x + self.velocity * math.sin(self.angle) * dt, self.y - self.velocity * math.cos(self.angle) * dt)
    self:rotate(self.angle)
end

function OneBullet:goLeft()
    OneBullet.steerLeft = true
end

function OneBullet:goRight()
    OneBullet.steerRight = true
end

function OneBullet:stopLeft()
    OneBullet.steerLeft = false
end

function OneBullet:stopRight()
    OneBullet.steerRight = false
end


function OneBullet:hit(other, dx, dy)
    print "Bullet Hit!"
end

