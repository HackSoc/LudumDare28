local class = require 'middleclass.middleclass'

require 'events.EntityEvent'
require 'entity.PlayerBullet'
require 'utils'

PlayerBulletEvent = class('events.PlayerBulletEvent', EntityEvent)

function PlayerBulletEvent:initialize(entityId)
    EntityEvent.initialize(self, entityId)
    self.bulletId = uniqueId()
end

function PlayerBulletEvent:safeApply(state, collider)
    local bullet = PlayerBullet:new(self.bulletId,
                                    state[self.entityId].x,
                                    state[self.entityId].y,
                                    collider)
    state[self.bulletId] = bullet
end
