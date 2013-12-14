local class = require 'middleclass.middleclass'
require 'entity.Entity'

Tile = class('entity.Tile', Entity)

function Tile:hit(other, dx, dy)
    if other.class ~= Tile then
        other:move(other.x, self.y - self.height/2 - other.height/2)
    end
end
