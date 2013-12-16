local class = require 'middleclass.middleclass'

require 'drawable.drawable'

TileDrawable = class('entity.TileDrawable', Drawable)
TileDrawable.tile = nil

function TileDrawable:initialize(tile)
    self.tile = tile
end

function TileDrawable:draw(x, y, orientation)
    self.tile:draw(x, y, self.angle, orientation, 1, self:getWidth()/2, self:getHeight()/2)
end

function TileDrawable:tick(state, collider)
end

function TileDrawable:getWidth()
    return self.tile.width
end

function TileDrawable:getHeight()
    return self.tile.height
end

function TileDrawable:rotate(r)
    self.angle = r
end
