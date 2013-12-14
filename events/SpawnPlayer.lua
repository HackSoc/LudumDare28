local class = require 'middleclass.middleclass'

require 'entity.Player'
require 'utils'

SpawnPlayer = class('events.SpawnPlayer', Event)

function SpawnPlayer:initialize()
    self.playerId = uniqueId()
end

function SpawnPlayer:apply(state, collider)
    local player = Player:new(self.playerId, 100, 460, collider)
    state[self.playerId] = player
end
