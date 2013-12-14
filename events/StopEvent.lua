local class = require 'middleclass.middleclass'
require 'events.EntityEvent'

StopEvent = class('events.StopEvent', EntityEvent)

function StopEvent:apply(state)
    state[self.entityId]:stop()
end
