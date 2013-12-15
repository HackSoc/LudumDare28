local class = require 'middleclass.middleclass'


StateCache = class('StateCache')

StateCache.states = {}

function StateCache:initialize()
    self.states = {}
end

function StateCache:invalidateAfter(t)
    for k, v in pairs(self.states) do
        if k > t then
            self.states[k] = nil
        end
    end
end

function StateCache:insert(state, t)
    self.states[t] = state
end

function StateCache:before(t)
    local lastK = nil
    for k, v in pairs(self.states) do
        if k > t then
            if lastK then
                return lastL, self.states[lastK]
            else
                return nil, nil
            end
        end
        lastK = k
    end
    if lastK then
        return lastK, self.states[lastK]
    end
    return nil, nil
end
