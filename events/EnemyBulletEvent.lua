local class = require 'middleclass.middleclass'

require 'events.EntityEvent'
require 'entity.EnemyBullet'
require 'utils'

EnemyBulletEvent = class('events.EnemyBulletEvent', EntityEvent)

function EnemyBulletEvent:initialize(entityId)
    EntityEvent.initialize(self, entityId)
    self.bulletId = uniqueId()
end

function EnemyBulletEvent:safeApply(state, collider)
    local bullet = EnemyBullet:new(self.bulletId,
                                   state[self.entityId].x,
                                   state[self.entityId].y,
                                   collider)
    state[self.bulletId] = bullet
end
