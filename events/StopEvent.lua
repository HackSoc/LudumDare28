local class = require 'middleclass.middleclass'
require 'events.EntityEvent'

StopEvent = class('events.StopEvent', EntityEvent)

function StopEvent:safeApply(state)
    state[self.entityId]:stop()
end
