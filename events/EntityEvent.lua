local class = require 'middleclass.middleclass'

EntityEvent = class('events.EntityEvent', Event)

function EntityEvent:initialize(entityId)
    self.entityId = entityId
end

function EntityEvent:apply(state, collider)
    if state[self.entityId] then
    	self:safeApply(state, collider)
    end
end

function EntityEvent:safeApply(state, collider)
end
