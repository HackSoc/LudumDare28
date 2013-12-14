local class = require 'middleclass.middleclass'
require 'entity.Entity'

Block = class('entity.Block', Entity)
Block.static.sprite = love.graphics.newImage("assets/block.png")

function Block:initialize(x, y, collider)
   Entity.initialize(self, x, y, self.class.sprite, collider)
end