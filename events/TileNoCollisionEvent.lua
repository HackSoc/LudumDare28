local class = require 'middleclass.middleclass'

require 'events.TileEvent'
require 'entity.Tile'
require 'entity.LeftTriangleTile'
require 'entity.RightTriangleTile'
require 'utils'

TileNoCollisionEvent = class('events.TileNoCollisionEvent', TileEvent)

function TileNoCollisionEvent:apply(state, collider)
    TileEvent.apply(self, state, collider)
    state[self.tileId].ghosted = true
end
