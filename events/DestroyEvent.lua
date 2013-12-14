local class = require 'middleclass.middleclass'
require 'events.EntityEvent'

DestroyEvent = class('events.DestroyEvent', EntityEvent)

function DestroyEvent:safeApply(state, collider)
    state[self.entityId] = nil
end
