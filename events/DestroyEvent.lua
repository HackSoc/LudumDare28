local class = require 'middleclass.middleclass'
require 'events.EntityEvent'

DestroyEvent = class('events.DestroyEvent', EntityEvent)

function DestroyEvent:safeApply(state, collider)
    collider:setGhost(state[self.entityId].hitbox)
    state[self.entityId]:ghost()
end
