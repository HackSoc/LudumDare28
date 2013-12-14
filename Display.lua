local class = require 'middleclass.middleclass'

Display = class('Display')
Display.static.background = love.graphics.newImage("assets/background.png")

function Display:draw(entities)
    love.graphics.draw(self.class.background, 0, 0)

    for key,entity in pairs(entities) do
        entity:draw()
    end
end

return Display
