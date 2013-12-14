local class = require 'middleclass.middleclass'

require 'events.Event'
require 'entity.Tile'
require 'utils'

TileEvent = class('events.TileEvent', Event)

function TileEvent:initialize(x, y, sprite)
    self.tileId = uniqueId()
    self.sprite = sprite
    self.x = x
    self.y = y
end

function TileEvent:apply(state, collider)
    local tile = Tile:new(self.tileId,
                          self.x,
                          self.y,
                          self.sprite,
                          collider)
    state[self.tileId] = tile
end
