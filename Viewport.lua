local class = require 'middleclass.middleclass'

Viewport = class('Viewport')
Viewport.centerX = 0
Viewport.centerY = 0
Viewport.maxPan = 0

function Viewport:initialize(width, height, maxPan)
    self.width = width
    self.height = height
    self.maxPan = maxPan
end

function Viewport:draw(entities)
    for key, entity in pairs(entities) do
        if type(key) == "number" and entity.visible then
            love.graphics.setColor({255,255,255,255})
            entity:draw(self.centerX, self.centerY)
        end
    end
end

function Viewport:move(x, y)
    self.centerX = x - self.width / 2
    self.centerY = y - self.height / 2

    if self.centerX < 0 then
        self.centerX = 0
    elseif self.centerX > self.maxPan then
        self.centerX = self.maxPan
    end
end

return Viewport
