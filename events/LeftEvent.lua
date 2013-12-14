local class = require 'middleclass.middleclass'

LeftEvent = class('events.LeftEvent', Event)

LeftentityId = nil

function LeftEvent:initialize(entityId)
    self.entityId = entityId
end

function LeftEvent:apply(state)
    state[self.entityId]:startLeft()
end
