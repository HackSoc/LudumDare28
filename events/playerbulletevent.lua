local class = require 'middleclass.middleclass'

require 'events.entityevent'
require 'entity.playerbullet'
require 'utils'

PlayerBulletEvent = class('events.PlayerBulletEvent', EntityEvent)

PlayerBulletEvent.fireSound = nil

function PlayerBulletEvent:initialize(entityId, dir)
    EntityEvent.initialize(self, entityId)
    self.bulletId = uniqueId()
    self.dir = dir
    self.fireSound = love.audio.newSource("sound/shoot.wav")
end

function PlayerBulletEvent:safeApply(state, collider)
    local bullet = PlayerBullet:new(self.bulletId,
                                    state[self.entityId].x,
                                    state[self.entityId].y,
                                    collider,
                                    self.dir)
    state[self.bulletId] = bullet
    love.audio.stop(self.fireSound)
    love.audio.rewind(self.fireSound)
    table.insert(state["sfx"], self.fireSound)
end
