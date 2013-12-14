local class = require 'middleclass.middleclass'

Event = class('Event')

function Event:apply(state)
end

TickEvent = class('TickEvent', Event)

function TickEvent:apply(state)
    for key, entity in pairs(state) do
        entity:tick()
    end
end

LeftEvent = class('LeftEvent', Event)

LeftentityId = nil

function LeftEvent:initialize(entityId)
    self.entityId = entityId
end

function LeftEvent:apply(state)
    state[self.entityId]:startLeft()
end

RightEvent = class('RightEvent', Event)

RightentityId = nil

function RightEvent:initialize(entityId)
    self.entityId = entityId
end

function RightEvent:apply(state)
    state[self.entityId]:startRight()
end


StopEvent = class('StopEvent', Event)

StopEvent.entityId = nil

function StopEvent:initialize(entityId)
    self.entityId = entityId
end

function StopEvent:apply(state)
    state[self.entityId]:stop()
end
