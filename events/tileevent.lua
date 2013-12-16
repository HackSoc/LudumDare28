local class = require 'middleclass.middleclass'

require 'events.event'
require 'entity.tile'
require 'entity.lefttriangletile'
require 'entity.righttriangletile'
require 'utils'
require 'drawable.drawable'

TileEvent = class('events.TileEvent', Event)

function TileEvent:initialize(x, y, tile)
    self.tileId = uniqueId()
    self.tile = tile
    self.x = x
    self.y = y
end

function TileEvent:apply(state, collider)
    local klass
    if self.tile.id == 35 or self.tile.id == 33 or self.tile.id == 30 or self.tile.id == 106 then
        klass = LeftTriangleTile
    elseif self.tile.id == 9 or self.tile.id == 96 or self.tile.id == 6 then
        klass = RightTriangleTile
    else
        klass = Tile
    end

    local tile = klass:new(self.tileId,
                           self.x,
                           self.y,
                           self.tile,
                           collider)
                          
    state[self.tileId] = tile
end
