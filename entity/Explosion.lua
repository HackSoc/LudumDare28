local class = require 'middleclass.middleclass'

require 'entity.Entity'
require 'misclibs.AnAL.AnAL'
require 'utils'

constants = require 'constants'
Display = require 'Display'

Explosion = class('entity.Explosion', Entity)
Explosion.static.sprite = love.graphics.newImage("assets/explosion.png")
Explosion.static.frameWidth = 96
Explosion.static.frameHeight = 96
Explosion.lastFrame = -1

function Explosion:initialize(id, x, y, collider)
    Entity.initialize(self, id, x, y, self.class.sprite, collider)
    self.anim = newAnimation(self.class.sprite,
                             self.class.frameWidth,
                             self.class.frameHeight,
                             constants.frameDuration,
                             0)
    self.anim:setMode("once")
end

function Explosion:rotate(angle)
    -- This space intentionally left blank
end

function Explosion:draw()
    self.anim:draw(self.x - Display.static.background.viewportX, self.y)
end

function Explosion:tick(state, collider)
    self.anim:update(constants.frameDuration)
    if self.anim:getCurrentFrame() == self.lastFrame then
        self:ghost()
    else
        self.lastFrame = self.anim:getCurrentFrame()
    end
end
