local class = require 'middleclass.middleclass'

require 'entity.tile'

LeftTriangleTile = class('entity.LeftTriangleTile', Tile)

function LeftTriangleTile:createHitbox(collider)
    return collider:addPolygon(self.id,
                               self:right(),
                               self:bottom(),
                               self:right(),
                               self:top(),
                               self:left(),
                               self:bottom())
end