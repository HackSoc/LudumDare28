local class = require 'middleclass.middleclass'
require 'entity.Entity'
require 'entity.Wall'

OneBullet = class('OneBullet', Entity)
OneBullet.static.sprite = love.graphics.newImage("assets/bullet.png")
OneBullet.velocity = 200
OneBullet.steerRate = 4
OneBullet.accRate = 100

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
    
    if self.doAccelerate then
        self.velocity = self.velocity + self.accRate * dt
    end
    
    if self.doBrake then
        self.velocity = self.velocity - self.accRate * dt
    end
    
    if self.velocity < 50 then
        self.velocity = 50
    end
    
    if self.velocity > 400 then
        self.velocity = 400
    end
    
    if (self.x > 800) then
        self.x = self.x - 800
    end
    
    if (self.y > 600) then
        self.y = self.y - 600
    end
    
    if (self.x < 0) then
        self.x = self.x + 800
    end
    
    if (self.y < 0) then
        self.y = self.y + 600
    end
    
    self:move(self.x + self.velocity * math.sin(self.angle) * dt, self.y - self.velocity * math.cos(self.angle) * dt)
    self:rotate(self.angle)
end

function OneBullet:accelerate()
   self.doAccelerate=true 
end

function OneBullet:stopAccelerate()
   self.doAccelerate=false
end

function OneBullet:brake()
    self.doBrake = true
end

function OneBullet:stopBrake()
    self.doBrake = false
end

function OneBullet:goLeft()
    self.steerLeft = true
end

function OneBullet:goRight()
    self.steerRight = true
end

function OneBullet:stopLeft()
    self.steerLeft = false
end

function OneBullet:stopRight()
    self.steerRight = false
end


function OneBullet:hit(other, dx, dy)
    print "Bullet Hit!"
end

