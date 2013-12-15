local class = require 'middleclass.middleclass'
require 'entity.Tile'

RightTriangleTile = class('entity.RightTriangleTile', Tile)

function RightTriangleTile:initialize(id, x, y, sprite, collider, nocollision)
    Entity.initialize(self, id, x, y, sprite, collider)
end

function RightTriangleTile:createHitbox(collider)
    return collider:addPolygon(self.id,
                               self:right(),
                               self:bottom(),
                               self:left(),
                               self:bottom(),
                               self:left(),
                               self:top())
end