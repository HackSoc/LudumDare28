local class = require 'middleclass.middleclass'
require 'Background'

Display = class('Display')
Display.background = nil
Display.viewportX = 0
Display.viewportY = 0
Display.maxPan = 0

function Display:initialize(level)
    self.background = Background:new(level)
    self.maxPan = self.background.map.width*self.background.map.tileWidth - 836
end

function Display:draw(entities)
    self.background:draw()

    for key,entity in pairs(entities) do
        if type(key) == "number" and entity.visible then
            love.graphics.setColor({255,255,255,255})
            entity:draw(self.viewportX, self.viewportY)
        end
    end
end

function Display:viewport(x, y)
    self.viewportX = x - 400
    self.viewportY = y - 300

    if self.viewportX < 0 then
        self.viewportX = 0
    elseif self.viewportX > self.maxPan then
        self.viewportX = self.maxPan
    end
end

return Display
