local class = require 'middleclass.middleclass'

require 'utils'

TickEvent = class('events.TickEvent', Event)

function TickEvent:apply(state, collider)
    for key, entity in pairs(shallowcopy(state)) do
        entity:tick(state)
    end
end
