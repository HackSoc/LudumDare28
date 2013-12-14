local class = require 'middleclass.middleclass'
require 'events.EntityEvent'

LeftEvent = class('events.LeftEvent', EntityEvent)

function LeftEvent:apply(state)
    state[self.entityId]:startLeft()
end
