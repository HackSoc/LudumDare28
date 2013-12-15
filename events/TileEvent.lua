local class = require 'middleclass.middleclass'

require 'events.Event'
require 'entity.Tile'
require 'entity.LeftTriangleTile'
require 'utils'

TileEvent = class('events.TileEvent', Event)
TileEvent.static.tile = {}
for i = 0, 156 do
    k = 0
    if i > 11 then
        k = -1
    end
    TileEvent.static.tile[i+1+k] = love.graphics.newImage("assets/tiles"..i..".png") 
end

function TileEvent:initialize(x, y, tileNo)
    self.tileId = uniqueId()
    self.tileNo = tileNo
    self.x = x
    self.y = y
end

function TileEvent:apply(state, collider)
    local klass
    if self.tileNo == 35 then
        klass = LeftTriangleTile
    else
        klass = Tile
    end
    local tile = klass:new(self.tileId,
                          self.x,
                          self.y,
                          self.class.tile[self.tileNo],
                          collider)
                          
    state[self.tileId] = tile
end
