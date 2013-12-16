local class = require 'middleclass.middleclass'

require 'ColliderWrapper'

require 'utils'

require 'events.Event'

require 'StateCache'

EventLog = class('EventLog')

EventLog.events = {}
EventLog.cache = nil

function EventLog:initialize(startState)
    self.collider = ColliderWrapper:new(self)
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

    -- if the event happens at 0, insert the event
    table.insert(newEvents, e)

    -- wind time forwards, inserting the event when get to the right point
    for _, e in ipairs(self.events) do
        table.insert(newEvents, e)
        if e.class == TickEvent then 
            seenTicks = seenTicks + 1
            if seenTicks == t then
                table.insert(newEvents, event)
            end
        end
    end

    -- if we didn't get to insert the event, push out the log to contain enough TickEvents
    -- and insert
    if seenTicks < t then
        for i = seenTicks, t-1, 1 do
            table.insert(newEvents, TickEvent:new())
        end
        table.insert(newEvents, event)
    end

    self.cache:invalidateAfter(t)
    self.events = newEvents
end

function EventLog:eventsInRange(first, last)
    local events = {}
    local time = 0
    for _, e in ipairs(self.events) do
        if time >= first and time < last then
            table.insert(events, e)
        end
        if e.class == TickEvent then
            time = time + 1
        end
        if time > last then
            break
        end
    end
    if time < last then 
        for i = time, last-1, 1 do
            table.insert(events, TickEvent:new())
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
        state = self:applyEvents(self.startState, events, 0)
    else
        local events = self:eventsInRange(cacheTime, t)
        state = self:applyEvents(cached, events, cacheTime)
    end
    self.cache:insert(state, t)
    self:sanitizeCollider(state)
    return state
end


function EventLog:applyEvents(state, events, startTime)
    local newState = copystate(state)
    local time = startTime
    for _, e in ipairs(events) do
        e:apply(newState, self.collider)
        if e.class == TickEvent then
            time = time + 1
            self.collider:tick(time, newState)
        end
    end
    return newState
end

function EventLog:reset()
    self.cache:invalidateAfter(0)
end

function EventLog:sanitizeCollider(entities)
    for k, e in pairs(entities) do
        if type(k) == "number" then
            if e.ghosted then
                self.collider:setGhost(e.hitbox)
            else
                self.collider:setSolid(e.hitbox)
            end
        end
    end
end
