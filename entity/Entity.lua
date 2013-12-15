local class = require 'middleclass.middleclass'

require 'utils'

Entity = class('entity.Entity')
Entity.id = nil
Entity.x = 0
Entity.y = 0
Entity.width = 0
Entity.height = 0
Entity.sprite = nil
Entity.visible = true
Entity.hitbox = nil
Entity.dx = 0
Entity.dy = 0
Entity.ghosted = false
Entity.orientation = 1

Entity.static.debugHitboxes = true

function Entity:initialize(id, x, y, sprite, collider)
    self.id = id
    self.x = x
    self.y = y
    self.width = sprite:getWidth()
    self.height = sprite:getHeight()
    self.sprite = sprite

    self.hitbox = self:createHitbox(collider)
end

function Entity:createHitbox(collider)
    return collider:addRectangle(self.id,
                                 self:left(),
                                 self:top(),
                                 self.width,
                                 self.height)
end

function Entity:left()
    return self.x - self.width/2
end

function Entity:top()
    return self.y - self.height/2
end

function Entity:right()
    return self.x + self.width/2
end

function Entity:bottom()
    return self.y + self.height/2
end

function Entity:rotate(angle)
    self.sprite.rotate(angle)
    self.hitbox:setRotation(angle)
end

function Entity:draw()
    self.sprite:draw(self.x - Display.static.background.viewportX, self.y)

    if self.class.debugHitboxes then
        x1, y1, x2, y2 = self.hitbox:bbox()

        x1 = x1 - Display.static.background.viewportX
        x2 = x2 - Display.static.background.viewportX

        resetDraw(
            function ()
                if self.ghosted then
                    love.graphics.setColor(255, 100, 150, 255)
                else
                    love.graphics.setColor(50, 100, 150, 255)
                end
                love.graphics.rectangle("line", x1, y1, x2 - x1, y2 - y1)
            end)
    end
end


function Entity:tick(state, collider)
    self:move(self.x + self.dx,
              self.y + self.dy)
end

function Entity:move(x, y)
    self.x = x
    self.y = y
    self.hitbox:moveTo(x, y)
end

function Entity:hit(other, dx, dy)
    return false
end

function Entity:startLeft()
    self.orientation = -1
    self.sprite.orientation = -1
end

function Entity:startRight()
    self.orientation = 1
    self.sprite.orientation = 1
end

function Entity:stop()
    self.dx = 0
end

function Entity:ghost()
    self.visible = false
    self.ghosted = true
end
