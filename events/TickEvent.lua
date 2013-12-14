local class = require 'middleclass.middleclass'

TickEvent = class('events.TickEvent', Event)

function TickEvent:initialize(collider)
    self.collider = collider
end

function TickEvent:apply(state)
    self.collider:update(0)
    for key, entity in pairs(state) do
        entity:tick()
    end
end