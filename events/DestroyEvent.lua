local class = require 'middleclass.middleclass'
require 'events.EntityEvent'

DestroyEvent = class('events.DestroyEvent', EntityEvent)

function DestroyEvent:apply(state)
    state[self.entityId] = nil
end
