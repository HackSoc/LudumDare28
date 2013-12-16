local class = require 'middleclass.middleclass'

require 'events.entityevent'
require 'entity.enemybullet'
require 'utils'

EnemyBulletEvent = class('events.EnemyBulletEvent', EntityEvent)

function EnemyBulletEvent:initialize(entityId, dir)
    EntityEvent.initialize(self, entityId)
    self.bulletId = uniqueId()
    self.dir = dir
end

function EnemyBulletEvent:safeApply(state, collider)
    local bullet = EnemyBullet:new(self.bulletId,
                                   state[self.entityId].x,
                                   state[self.entityId].y,
                                   collider,
                                   self.dir)
    state[self.bulletId] = bullet
end
