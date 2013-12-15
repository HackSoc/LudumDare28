local class = require 'middleclass.middleclass'
require 'Background'

Display = class('Display')
Display.static.background = Background:new()

function Display:draw(entities)
    Display.static.background:draw()

    for key,entity in pairs(entities) do
        if entity.visible then
            entity:draw()
        end
    end
end

return Display
