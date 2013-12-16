local class = require 'middleclass.middleclass'

require 'entity.entity'
require 'drawable.tiledrawable'

Tile = class('entity.Tile', Entity)

function Tile:initialize(id, x, y, tile, collider)
    Entity.initialize(self, id, x, y, TileDrawable:new(tile), collider)
end

function Tile:tick(state, collider)
    -- This is necessary.
end

function Tile:hit(other, dx, dy)
    if other:isInstanceOf(Mob) then
        other:move(other.x - dx, other.y - dy)
        if dy ~= 0 then
            other.dy = 0
        end
    end
end
