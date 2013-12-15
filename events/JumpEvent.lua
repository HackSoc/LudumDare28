local class = require 'middleclass.middleclass'

require 'entity.Player'
require 'utils'

JumpEvent = class('events.JumpEvent', EntityEvent)

JumpEvent.playerId = playerId

function JumpEvent:initialize(entityId)
    EntityEvent.initialize(self, entityId)
end

function JumpEvent:safeApply(state, collider)
    state[self.entityId]:jump()
end
