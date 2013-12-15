local class = require 'middleclass.middleclass'
require 'entity.Tile'

LeftTriangleTile = class('entity.LeftTriangleTile', Tile)

function LeftTriangleTile:initialize(id, x, y, sprite, collider, nocollision)
    Entity.initialize(self, id, x, y, sprite, collider)
end

function LeftTriangleTile:createHitbox(collider)
    return collider:addPolygon(self.id,
                               self:right(),
                               self:bottom(),
                               self:right(),
                               self:top(),
                               self:left(),
                               self:bottom())
end