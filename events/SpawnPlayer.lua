local class = require 'middleclass.middleclass'

require 'entity.Player'
require 'utils'

SpawnPlayer = class('events.SpawnPlayer', Event)

function SpawnPlayer:initialize(collider)
    self.collider = collider
    self.playerId = uniqueId()
end

function SpawnPlayer:apply(state)
    local player = Player:new(100, 460, self.collider)
    state[self.playerId] = player
end
