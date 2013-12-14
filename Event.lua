local class = require 'middleclass.middleclass'

Event = class('event.Event')

function Event:apply(state)
end

TickEvent = class('event.TickEvent', Event)

function TickEvent:apply(state)
    for key, entity in pairs(state) do
        entity:tick()
    end
end

LeftEvent = class('event.LeftEvent', Event)

LeftEvent.entity = nil

function LeftEvent:initialize(entity)
    self.entity = entity
end

function LeftEvent:apply(state)
    self.entity:startLeft()
end

RightEvent = class('event.RightEvent', Event)

RightEvent.entity = nil

function RightEvent:initialize(entity)
    self.entity = entity
end

function RightEvent:apply(state)
    self.entity:startRight()
end
