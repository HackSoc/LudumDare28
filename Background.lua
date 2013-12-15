local class = require 'middleclass.middleclass'

require 'events.TileEvent'
require 'events.TileNoCollisionEvent'

Background = class('Background')
Background.tile = {}
Background.mapWidth = 70
Background.viewportX = 0

Background.map = {
    0,   0,   0,   0,   0,  0,  0,   0,  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0, 0,   0,   0, 0,   0,   0, 0,  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0, 
    0,   0,   0,   0,   0,  0,  0,   0,  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0, 0,   0,   0, 0,   0,   0, 0,  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0, 
    0,   0,   0,   0,   0,  0,  0,   0,  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0, 0,   0,   0, 0,   0,   0, 0,  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0, 
    133, 0,   0,   0,   0,  0,  0,   0,  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   33,  103, 103, 9,   0,   0,   0,   0,   0, 0,   0,   0, 0,   0,   0, 0,  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0, 
    133, 0,   0,   0,   0,  0,  0,   0,  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   33,  21,  153, 153, 152, 9,   0,   0,   0,   0, 0,   0,   0, 0,   0,   0, 0,  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0, 
    133, 0,   0,   0,   0,  0,  0,   0,  0,   0,   0,   0,   13,  13,  0,   0,   0,   0,   0,   0,   0,   0,   0,   106, 36,  36,  95,  0,   0,   0,   67,  0,   0,   0,   0,   0,   0,   33,  21,  153, 153, 153, 153, 152, 9,   0,   0,   0, 0,   0,   0, 0,   0,   0, 0,  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0, 
    133, 133, 0,   0,   0,  0,  0,   0,  0,   35,  135, 135, 135, 135, 135, 135, 153, 153, 153, 153, 153, 153, 135, 135, 135, 135, 135, 135, 135, 135, 135, 135, 135, 135, 135, 135, 135, 153, 153, 153, 153, 153, 153, 153, 152, 9,   0,   0, 0,   0,   0, 0,   0,   0, 0,  0,   106, 128, 128, 128, 128, 128, 128, 96,  0,   0,   0,   0,   0,   0, 
    133, 133, 133, 133, 0,  0,  133, 0,  35,  155, 155, 155, 155, 155, 155, 155, 153, 153, 153, 153, 153, 153, 153, 153, 153, 153, 153, 153, 153, 153, 153, 153, 153, 153, 153, 153, 153, 153, 153, 153, 153, 153, 153, 153, 153, 152, 9,   0, 0,   0,   0, 0,   0,   0, 0,  106, 128, 128, 128, 128, 128, 128, 128, 128, 96,  0,   0,   0,   0,   0, 
    36,  36,  36,  36,  36, 36, 36,  36, 155, 155, 155, 155, 155, 155, 155, 155, 153, 153, 153, 153, 153, 153, 153, 153, 153, 153, 153, 153, 153, 153, 153, 153, 153, 153, 153, 153, 153, 153, 153, 153, 153, 153, 153, 153, 153, 153, 152, 0, 103, 103, 0, 103, 103, 0, 36, 0,   128, 128, 128, 128, 128, 128, 128, 128, 128, 104, 104, 104, 104, 104
    }

Background.objects = {
    0 ,0 ,0  ,0 ,0 ,0  ,0 ,0 ,0 ,0 ,0 ,0 ,0  ,0 ,0 ,0 ,0  ,0  ,0  ,0  ,0  ,0  ,0 ,0 ,0  ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0  ,0 ,0 ,0 ,0 ,0 ,0   ,0  ,0 ,0 ,0 ,0 ,0 ,0  ,0 ,0 ,0  ,0 ,0 ,0  ,0 ,0   ,0 ,0   ,0   ,0   ,0   ,0   ,0   ,0 ,0 ,0 ,0  ,0 ,0  ,0 ,
    0 ,0 ,0  ,0 ,0 ,0  ,0 ,0 ,0 ,0 ,0 ,0 ,0  ,0 ,0 ,0 ,0  ,0  ,0  ,0  ,0  ,0  ,0 ,0 ,0  ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,20 ,0 ,0 ,0 ,0 ,0 ,0   ,0  ,0 ,0 ,0 ,0 ,0 ,0  ,0 ,0 ,0  ,0 ,0 ,0  ,0 ,0   ,0 ,0   ,0   ,0   ,0   ,0   ,0   ,0 ,0 ,0 ,0  ,0 ,0  ,0 ,
    0 ,0 ,0  ,0 ,0 ,0  ,0 ,0 ,0 ,0 ,0 ,0 ,0  ,0 ,0 ,0 ,0  ,0  ,0  ,0  ,0  ,0  ,0 ,0 ,0  ,0 ,0 ,0 ,26 ,0 ,0 ,0 ,0 ,0 ,32 ,0 ,0 ,0 ,0 ,0 ,121 ,0  ,0 ,0 ,0 ,0 ,0 ,0  ,0 ,0 ,0  ,0 ,0 ,0  ,0 ,0   ,0 ,0   ,0   ,0   ,0   ,0   ,0   ,0 ,0 ,0 ,0  ,0 ,0  ,0 ,
    0 ,0 ,0  ,0 ,0 ,0  ,0 ,0 ,0 ,0 ,0 ,0 ,26 ,0 ,0 ,0 ,26 ,0  ,0  ,0  ,0  ,26 ,0 ,0 ,0  ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,32 ,0 ,0 ,0 ,0 ,0 ,45  ,45 ,0 ,0 ,0 ,0 ,0 ,0  ,0 ,0 ,0  ,0 ,0 ,0  ,0 ,0   ,0 ,0   ,0   ,0   ,0   ,0   ,0   ,0 ,0 ,0 ,0  ,0 ,0  ,0 ,
    0 ,0 ,0  ,0 ,0 ,0  ,0 ,0 ,0 ,0 ,0 ,0 ,0  ,0 ,0 ,0 ,0  ,0  ,0  ,0  ,0  ,0  ,0 ,0 ,41 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,32 ,0 ,0 ,0 ,0 ,0 ,0   ,0  ,0 ,0 ,0 ,0 ,0 ,0  ,0 ,0 ,0  ,0 ,0 ,0  ,0 ,0   ,0 ,0   ,0   ,0   ,0   ,0   ,0   ,0 ,0 ,0 ,0  ,0 ,0  ,0 ,
    0 ,0 ,26 ,0 ,0 ,26 ,0 ,0 ,0 ,0 ,0 ,0 ,0  ,0 ,0 ,0 ,0  ,0  ,0  ,0  ,0  ,0  ,0 ,0 ,0  ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,32 ,0 ,0 ,0 ,0 ,0 ,0   ,0  ,0 ,0 ,0 ,0 ,0 ,0  ,0 ,0 ,0  ,0 ,0 ,0  ,0 ,0   ,0 ,0   ,41  ,0   ,0   ,41  ,0   ,0 ,0 ,0 ,0  ,0 ,0  ,0 ,
    0 ,0 ,0  ,0 ,0 ,0  ,0 ,0 ,0 ,0 ,0 ,0 ,0  ,0 ,0 ,0 ,57 ,57 ,57 ,57 ,57 ,57 ,0 ,0 ,0  ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0  ,0 ,0 ,0 ,0 ,0 ,0   ,0  ,0 ,0 ,0 ,0 ,0 ,0  ,0 ,0 ,0  ,0 ,0 ,0  ,0 ,0   ,0 ,118 ,118 ,118 ,118 ,118 ,118 ,0 ,0 ,0 ,0  ,0 ,46 ,0 ,
    0 ,0 ,0  ,0 ,0 ,0  ,0 ,0 ,0 ,0 ,0 ,0 ,0  ,0 ,0 ,0 ,0  ,0  ,0  ,0  ,0  ,0  ,0 ,0 ,0  ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0  ,0 ,0 ,0 ,0 ,0 ,0   ,0  ,0 ,0 ,0 ,0 ,0 ,0  ,0 ,0 ,0  ,0 ,0 ,0  ,0 ,0   ,0 ,0   ,0   ,0   ,0   ,0   ,0   ,0 ,0 ,0 ,65 ,0 ,58 ,0 ,
    0 ,0 ,0  ,0 ,0 ,0  ,0 ,0 ,0 ,0 ,0 ,0 ,0  ,0 ,0 ,0 ,0  ,0  ,0  ,0  ,0  ,0  ,0 ,0 ,0  ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0  ,0 ,0 ,0 ,0 ,0 ,0   ,0  ,0 ,0 ,0 ,0 ,0 ,44 ,0 ,0 ,44 ,0 ,0 ,44 ,0 ,128 ,0 ,0   ,0   ,0   ,0   ,0   ,0   ,0 ,0 ,0 ,0  ,0 ,0  ,0
}

function Background:initialize()
    
end

function Background:getEvents()
    events = {}
    for y = 0, 8 do
        for x = 0, self.mapWidth-1 do
            tileNo = self.map[y*self.mapWidth+x+1]
            
            if tileNo ~= 0 then
                table.insert(events, TileEvent:new(x * 70, y * 70, tileNo))
            end
        end
    end
    
    for y = 0, 8 do
        for x = 0, self.mapWidth-1 do
            tileNo = self.objects[y*self.mapWidth+x+1]
            
            if tileNo ~= 0 then
                table.insert(events, TileNoCollisionEvent:new(x * 70, y * 70, tileNo))
            end
        end
    end
    
    return events
end

function Background:draw()
    
end

function Background:panX(newX)
    self.viewportX = newX - 400
    if self.viewportX < 0 then
       self.viewportX = 0 
    end
end
