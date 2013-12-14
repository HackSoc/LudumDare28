local class = require 'middleclass.middleclass'

eventTypes = {moveleft=0, moveright=1, tick=2}

Event = class('event.Event')

Event.entity = nil
Event.type = nil

function Event:initialize(entity, type)
    self.entity = entity
    self.type = type
end
