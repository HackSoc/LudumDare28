local class = require 'middleclass.middleclass'
require 'entity.Entity'

Tile = class('entity.Tile', Entity)
Tile.collider = nil

function Tile:initialize(id, x, y, sprite, collider, nocollision)
    Entity.initialize(self, id, x, y, sprite, collider)
end

function Tile:hit(other, dx, dy)    
    if other:isInstanceOf(Mob) then
        other:move(other.x - dx, other.y - dy)
        if dy ~= 0 then
            other.dy = 0
        end
    end
end
