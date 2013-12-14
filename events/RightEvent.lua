local class = require 'middleclass.middleclass'
require 'events.EntityEvent'

RightEvent = class('events.RightEvent', EntityEvent)

function RightEvent:apply(state)
    state[self.entityId]:startRight()
end
