local class = require 'middleclass.middleclass'
require 'Background'

Display = class('Display')
Display.background = nil
Display.viewportX = 0
Display.viewportY = 0

function Display:initialize(mapfile)
    self.background = Background:new(mapfile)
end

function Display:draw(entities)
    self.background:draw()

    for key,entity in pairs(entities) do
        if entity.visible then
            love.graphics.setColor({255,255,255,255})
            entity:draw(viewportX, viewportY)
        end
    end
end

function Display:viewport(x, y)
    self.viewportX = x
    self.viewportY = y
end

return Display
