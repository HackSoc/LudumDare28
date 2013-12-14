local class = require 'middleclass.middleclass'
require 'events.EntityEvent'

RightEvent = class('events.RightEvent', EntityEvent)

function RightEvent:safeApply(state)
    state[self.entityId]:startRight()
end
