local class = require 'middleclass.middleclass'

EntityEvent = class('events.EntityEvent', Event)

function EntityEvent:initialize(entityId)
    self.entityId = entityId
end

function EntityEvent:apply(state)
    if state[self.entityId] then
    	self:safeApply(state)
    end
end

function EntityEvent:safeApply(state)
    
end

