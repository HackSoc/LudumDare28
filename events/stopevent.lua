local class = require 'middleclass.middleclass'

require 'events.entityevent'

StopEvent = class('events.StopEvent', EntityEvent)

function StopEvent:safeApply(state, collider)
    state[self.entityId]:stop()
end
