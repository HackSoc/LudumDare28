local class = require 'middleclass.middleclass'

RightEvent = class('events.RightEvent', Event)

RightentityId = nil

function RightEvent:initialize(entityId)
    self.entityId = entityId
end

function RightEvent:apply(state)
    state[self.entityId]:startRight()
end
