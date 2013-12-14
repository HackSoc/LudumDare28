local class = require 'middleclass.middleclass'
require 'entity.Entity'

Tile = class('entity.Tile', Entity)
Tile.collider = nil

function Tile:initialize(id, x, y, sprite, collider, nocollision)
    Tile.collider = collider
    Entity.initialize(self, id, x, y, sprite, collider)
    if (nocollision) then
       eventLog.collider.collider:setGhost(self.hitbox) 
    end
end

function Tile:hit(other, dx, dy)
    if other:isInstanceOf(Mob) then
        other:move(other.x, self.y - self.height/2 - other.height/2)
    end
end
