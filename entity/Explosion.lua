local class = require 'middleclass.middleclass'

require 'entity.Entity'
require 'misclibs.AnAL.AnAL'
require 'utils'
require 'drawable.Animation'

Explosion = class('entity.Explosion', Entity)
Explosion.static.frameWidth = 96
Explosion.static.frameHeight = 96
Explosion.sprite = nil
Explosion.lastFrame = -1

function Explosion:initialize(id, x, y, collider)
    self.sprite = Animation:new("assets/explosion.png",
                                Explosion.static.frameWidth,
                                Explosion.static.frameHeight)
    Entity.initialize(self, id, x, y, self.sprite, collider)
    self.sprite:setMode("once")
end

function Explosion:rotate(angle)
    -- This space intentionally left blank
end

function Explosion:tick(state, collider)
    if self.ghosted then return end

    self.sprite:tick(state, collider)
    if self.sprite:getCurrentFrame() == self.lastFrame then
        self:ghost()
    else
        self.lastFrame = self.sprite:getCurrentFrame()
    end
end
