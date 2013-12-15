local class = require 'middleclass.middleclass'

Drawable = class('entity.Drawable')
Drawable.image = nil
Drawable.angle = 0
Drawable.orientation = 1

function Drawable:initialize(image)
    self.image = image
end

function Drawable:draw(x, y)
    love.graphics.draw(self.image, x, y, self.angle, self.orientation, 1, self:getWidth()/2, self:getHeight()/2)
end

function Drawable:tick(state, collider)
end

function Drawable:getWidth()
    return self.image:getWidth()
end

function Drawable:getHeight()
    return self.image:getHeight()
end

function Drawable:flip()
    self.orientation = self.orientation * -1
end

function Drawable:rotate(r)
    self.angle = r
end

-- Helper function
function newSprite(path)
    return Drawable:new(love.graphics.newImage(path))
end
