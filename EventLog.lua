local class = require 'middleclass.middleclass'

require 'utils'

require 'Event'

EventLog = class('EventLog')

EventLog.events = {}

function EventLog:initialize()

end

function EventLog:apply(state, t)
    local seenTicks = 0
    for _, event in ipairs(self.events) do
        if (event.class == Tick) then
            seenTicks = seenTicks + 1
        else
            event:apply(state)
        end
        if (seenTicks > t) then break end
    end
end

function EventLog:append(event)
    local newLog = EventLog()
    for k, v in pairs(self.events) do
        newLog.events[k] = v
    end
    table.insert(newLog.events, event)
    return newLog
end

function EventLog:insert(event, t)
    local seenTicks = 0
    local newLog = EventLog()
    for _, e in ipairs(self.events) do
        table.insert(newLog, e)
        if (e.class == Tick) then 
            seenTicks = seenTicks + 1
            if seenTicks == t then
                table.insert(newLog, event)
            end
        end
    end
    return newLog
end
