local class = require 'middleclass.middleclass'

Scene = class('Scene')
Scene.static.background = love.graphics.newImage("assets/background.png")

function Scene:draw(entities)
    love.graphics.draw(self.class.background, 0, 0)

    for key,entity in pairs(entities) do
        entity:draw()
    end
end

return scene
