local class = require 'middleclass.middleclass'

require 'constants'

StateCache = class('StateCache')

StateCache.states = {}
-- the amount of time after a state will probably never be necessary that we keep it around
StateCache.static.slack = 10

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
        elseif k - t > constants.jumpTime + self.class.slack then
            -- prune entries that we will never need again
            self.states[k] = nil
        end
        lastK = k
    end
    if lastK then
        return lastK, self.states[lastK]
    end
    return nil, nil
end
