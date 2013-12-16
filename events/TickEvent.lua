local class = require 'middleclass.middleclass'

require 'utils'

TickEvent = class('events.TickEvent', Event)

function TickEvent:apply(state, collider)
    for key, entity in pairs(shallowcopy(state)) do
        -- everything with a numeric index in `state` is an entity
        -- everything else is something else
        if type(key) == "number" then
            entity:tick(state, collider)
        end
    end
end
