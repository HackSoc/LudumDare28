local class = require 'middleclass.middleclass'

require 'events.tileevent'
require 'entity.tile'
require 'entity.lefttriangletile'
require 'entity.righttriangletile'
require 'utils'

TileNoCollisionEvent = class('events.TileNoCollisionEvent', TileEvent)

function TileNoCollisionEvent:apply(state, collider)
    TileEvent.apply(self, state, collider)
    state[self.tileId].ghosted = true
end
