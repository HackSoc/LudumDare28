local class = require 'middleclass.middleclass'

require 'entity.Player'
require 'utils'

SpawnPlayer = class('events.SpawnPlayer', Event)
SpawnPlayer.x = 0
SpawnPlayer.y = 0

function SpawnPlayer:initialize(x, y, orientation, dy)
    self.playerId = uniqueId()
    self.x = x
    self.y = y
    self.dy = dy
    self.orientation = orientation
end

function SpawnPlayer:apply(state, collider)
    local player = Player:new(self.playerId,
                              self.x,
                              self.y,
                              collider,
                              self.orientation)

    state[self.playerId] = player
end
