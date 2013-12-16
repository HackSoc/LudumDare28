local class = require 'middleclass.middleclass'

require 'events.event'
require 'utils'

EraseEvent = class('events.EraseEvent', EntityEvent)


function EraseEvent:safeApply(state, collider)
    collider:remove(state[self.entityId].hitbox)
    state[self.entityId] = nil
end
