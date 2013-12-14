local class = require 'middleclass.middleclass'
require 'entity.Entity'

Tile = class('entity.Tile', Entity)

function Tile:initialize(id, x, y, sprite, collider)
   Entity.initialize(self, id, x, y, sprite, collider)
end