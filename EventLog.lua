local class = require 'middleclass.middleclass'

require 'ColliderWrapper'

require 'utils'

require 'events.Event'

EventLog = class('EventLog')

EventLog.events = {}

function EventLog:initialize()
    self.collider = ColliderWrapper:new(self)
    self.events = {}
end

function EventLog:apply(state, t)
    self.collider:clear()

    local seenTicks = 0
    local newState = copystate(state)
    for _, event in ipairs(self.events) do
        event:apply(newState, self.collider)
        if event.class == TickEvent then
            seenTicks = seenTicks + 1
        end
        if seenTicks > t then break end
    end
    return newState
end

function EventLog:append(event)
    table.insert(self.events, event)
end

function EventLog:insert(event, t)
    local seenTicks = 0
    local newEvents = {}
    for _, e in ipairs(self.events) do
        table.insert(newEvents, e)
        if e.class == TickEvent then 
            seenTicks = seenTicks + 1
            if seenTicks == t then
                table.insert(newEvents, event)
            end
        end
    end
    self.events = newEvents
end
