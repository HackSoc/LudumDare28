local class = require 'middleclass.middleclass'
local atl = require 'Advanced-Tiled-Loader'

local loader = atl.Loader
loader.path = "maps/"

require 'events.TileEvent'
require 'events.TileNoCollisionEvent'

Background = class('Background')
Background.bgimage = nil

function Background:initialize(level)
    self.bgimage = level.background
    self.map = loader.load(level.mapfile)
end

function Background:getEvents()
    local events = {}

    for x, y, tile in self.map("Map"):iterate() do
        table.insert(events, TileEvent:new(x * 70, y * 70, tile))
    end

    for x, y, tile in self.map("Objects"):iterate() do
        table.insert(events, TileNoCollisionEvent:new(x * 70, y * 70, tile))
    end
    
    return events
end

function Background:draw()
    love.graphics.draw(self.bgimage, 0, 0)
end
