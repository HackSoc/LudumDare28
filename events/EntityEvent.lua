local class = require 'middleclass.middleclass'

EntityEvent = class('events.EntityEvent', Event)

function EntityEvent:initialize(entityId)
    self.entityId = entityId
end
