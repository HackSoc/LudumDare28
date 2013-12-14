local class = require 'middleclass.middleclass'

StopEvent = class('events.StopEvent', Event)

StopEvent.entityId = nil

function StopEvent:initialize(entityId)
    self.entityId = entityId
end

function StopEvent:apply(state)
    state[self.entityId]:stop()
end
