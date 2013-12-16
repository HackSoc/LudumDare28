local class = require 'middleclass.middleclass'

require 'events.tileevent'
require 'entity.tile'
require 'entity.lefttriangletile'
require 'entity.righttriangletile'
require 'utils'
require 'constants'

TileNoCollisionEvent = class('events.TileNoCollisionEvent', TileEvent)

function TileNoCollisionEvent:apply(state, collider)
    TileEvent.apply(self, state, collider)
    state[self.tileId].ghosted = true
    state[self.tileId].zlevel = constants.z.level.scenery
end
