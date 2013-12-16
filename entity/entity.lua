local class = require 'middleclass.middleclass'

require 'utils'
require 'constants'

Entity = class('entity.Entity')
Entity.id = nil
Entity.x = 0
Entity.y = 0
Entity.width = 0
Entity.height = 0
Entity.sprite = nil
Entity.zlevel = constants.z.level.entities
Entity.visible = true
Entity.hitbox = nil
Entity.dx = 0
Entity.dy = 0
Entity.ghosted = false
Entity.orientation = 1

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

function Entity:draw(vx, vy)
    self.sprite:draw(math.floor(self.x - vx), math.floor(self.y - vy), self.orientation)

    if constants.debug then
        x1, y1, x2, y2 = self.hitbox:bbox()

        x1 = x1 - vx
        x2 = x2 - vx

        resetDraw(
            function ()
                if self.ghosted then
                    love.graphics.setColor(255, 100, 150, 255)
                else
                    love.graphics.setColor(50, 100, 150, 255)
                end
                love.graphics.rectangle("line", x1, y1 - vy, x2 - x1, y2 - y1 - vy)
            end)
    end
end


function Entity:tick(state, collider)
    self:move(self.x + self.dx * constants.speed,
              self.y + self.dy * constants.speed)
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
end

function Entity:startRight()
    self.orientation = 1
end

function Entity:stop()
    self.dx = 0
end

function Entity:ghost()
    self.visible = false
    self.ghosted = true
end
