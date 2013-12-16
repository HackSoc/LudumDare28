local class = require 'middleclass.middleclass'

require 'entity.tile'

RightTriangleTile = class('entity.RightTriangleTile', Tile)

function RightTriangleTile:createHitbox(collider)
    return collider:addPolygon(self.id,
                               self:right(),
                               self:bottom(),
                               self:left(),
                               self:bottom(),
                               self:left(),
                               self:top())
end