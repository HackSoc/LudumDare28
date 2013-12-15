local class = require 'middleclass.middleclass'

require 'entity.Player'
require 'utils'

JumpEvent = class('events.JumpEvent', EntityEvent)

function JumpEvent:safeApply(state, collider)
    state[self.entityId]:jump()
end
