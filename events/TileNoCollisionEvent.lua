local class = require 'middleclass.middleclass'

require 'events.Event'
require 'entity.Tile'
require 'utils'

TileNoCollisionEvent = class('events.TileEvent', Event)

function TileNoCollisionEvent:initialize(x, y, sprite)
    self.tileId = uniqueId()
    self.sprite = sprite
    self.x = x
    self.y = y
end

function TileNoCollisionEvent:apply(state, collider)
    local tile = Tile:new(self.tileId,
                          self.x,
                          self.y,
                          self.sprite,
                          collider, true)
                          
    state[self.tileId] = tile
end
