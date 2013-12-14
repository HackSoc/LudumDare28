local class = require 'middleclass.middleclass'

require 'ColliderWrapper'

require 'utils'

require 'events.Event'

require 'StateCache'

EventLog = class('EventLog')

EventLog.events = {}
EventLog.cache = nil

function EventLog:initialize(startState)
    self.collider = ColliderWrapper:new()
    self.events = {}
    self.startState = startState
    self.cache = StateCache:new()
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
    self.cache:invalidateAfter(t)
    self.events = newEvents
end

function EventLog:eventsInRange(first, last)
    local events = {}
    local time = 0
    for _, e in ipairs(self.events) do
        if e.class == TickEvent then
            time = time + 1
        end
        if time >= first and time < last then
            table.insert(events, e)
        end
        if time > last then
            break
        end
    end
    return events
end

function EventLog:play(t)
    local cacheTime, cached = self.cache:before(t)
    local state
    if not cacheTime then 
        self.collider:clear()
        local events = self:eventsInRange(0, t)
        state = self:applyEvents(startState, events)
    else
        local events = self:eventsInRange(cacheTime, t)
        state = self:applyEvents(cached, events)
    end
    self.cache:insert(state, t)
    return state
end


function EventLog:applyEvents(state, events)
    local newState = statecopy(state)
    for _, e in ipairs(events) do
        e:apply(newState, self.collider)
    end
    return newState
end

function EventLog:reset()
    self.cache:invalidateAfter(0)
end
