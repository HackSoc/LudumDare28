local class = require 'middleclass.middleclass'
require 'events.EntityEvent'

LeftEvent = class('events.LeftEvent', EntityEvent)

function LeftEvent:safeApply(state, collider)
    state[self.entityId]:startLeft()
end
