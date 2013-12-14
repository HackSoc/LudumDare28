local class = require 'middleclass.middleclass'

require 'entity.PlayerBullet'
require 'utils'

PlayerBulletEvent = class('events.PlayerBulletEvent', Event)

function PlayerBulletEvent:initialize(entityId)
    self.entityId = entityId
    self.bulletId = uniqueId()
end

function PlayerBulletEvent:apply(state)
    local bullet = PlayerBullet:new(state[self.entityId].x,
                                    state[self.entityId].y,
                                    state[self.entityId].collider)
    state[self.bulletId] = bullet
end
