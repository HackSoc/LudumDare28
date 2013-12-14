local class = require 'middleclass.middleclass'

TickEvent = class('events.TickEvent', Event)

function TickEvent:apply(state, collider)
    for key, entity in pairs(state) do
        entity:tick()
    end
end