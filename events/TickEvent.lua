local class = require 'middleclass.middleclass'

TickEvent = class('events.TickEvent', Event)

function TickEvent:apply(state, collider)
    collider:update(0)
    for key, entity in pairs(state) do
        entity:tick()
    end
end