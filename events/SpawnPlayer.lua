local class = require 'middleclass.middleclass'

require 'entity.Player'
require 'utils'

SpawnPlayer = class('events.SpawnPlayer', Event)

SpawnPlayer.x = nil
SpawnPlayer.y = nil

function SpawnPlayer:initialize(x, y)
    self.playerId = uniqueId()
    self.x = x
    self.y = y
end

function SpawnPlayer:apply(state, collider)
    local player = Player:new(self.playerId, self.x, self.y, collider)
    state[self.playerId] = player
end
