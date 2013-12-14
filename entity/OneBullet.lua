local class = require 'middleclass.middleclass'
require 'entity.Entity'
require 'entity.Wall'

OneBullet = class('OneBullet', Entity)
OneBullet.static.sprite = love.graphics.newImage("assets/ball.png")
OneBullet.angle = 0
OneBullet.velocity = 200
OneBullet.steerRate = 4

function OneBullet:initialize(collider)
    print (OneBullet.static.sprite)
    Entity.initialize(self, 200, 200, self.class.sprite, collider)
end

function OneBullet:update(dt)
    if OneBullet.steerLeft then
        OneBullet.angle = OneBullet.angle + (OneBullet.steerRate * dt)
    end
    
    if OneBullet.steerRight then
        OneBullet.angle = OneBullet.angle - (OneBullet.steerRate * dt)
    end
    
    self:move(self.x + OneBullet.velocity * math.sin(OneBullet.angle) * dt, self.y + OneBullet.velocity * math.cos(OneBullet.angle) * dt)
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

