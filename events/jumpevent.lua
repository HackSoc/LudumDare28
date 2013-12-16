local class = require 'middleclass.middleclass'

require 'entity.player'
require 'events.entityevent'
require 'utils'

JumpEvent = class('events.JumpEvent', EntityEvent)

function JumpEvent:safeApply(state, collider)
    state[self.entityId]:jump()
end
