local class = require 'middleclass.middleclass'
local atl = require 'Advanced-Tiled-Loader'

local loader = atl.Loader
loader.path = "maps/"

require 'events.TileEvent'
require 'events.TileNoCollisionEvent'

Background = class('Background')
Background.tile = {}
Background.mapWidth = 70

function Background:initialize(mapfile)
    self.map = loader.load(mapfile)
end

function Background:getEvents()
    events = {}

    for x, y, tile in self.map("Map"):iterate() do
        table.insert(events, TileEvent:new(x * 70, y * 70, tile))
    end

    for x, y, tile in self.map("Objects"):iterate() do
        table.insert(events, TileNoCollisionEvent:new(x * 70, y * 70, tile))
    end
    
    return events
end

function Background:draw()
end
