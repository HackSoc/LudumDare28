local class = require 'middleclass.middleclass'

require 'entity.EnemyBullet'
require 'utils'

EnemyBulletEvent = class('events.EnemyBulletEvent', Event)

function EnemyBulletEvent:initialize(entityId)
    self.entityId = entityId
    self.bulletId = uniqueId()
end

function EnemyBulletEvent:apply(state)
    local bullet = EnemyBullet:new(state[self.entityId].x,
                                   state[self.entityId].y,
                                   state[self.entityId].collider)
    state[self.bulletId] = bullet
end
