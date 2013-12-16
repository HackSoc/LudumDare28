local class = require 'middleclass.middleclass'

require 'events.entityevent'

RightEvent = class('events.RightEvent', EntityEvent)

function RightEvent:safeApply(state, collider)
    state[self.entityId]:startRight()
end
