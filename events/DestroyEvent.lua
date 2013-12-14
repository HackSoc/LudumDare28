local class = require 'middleclass.middleclass'
require 'events.EntityEvent'

DestroyEvent = class('events.DestroyEvent', EntityEvent)

function DestroyEvent:safeApply(state, collider)
    collider:remove(state[self.entityId].hitbox)
    state[self.entityId] = nil
end
