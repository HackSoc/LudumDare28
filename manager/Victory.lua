class = require 'middleclass.middleclass'
require 'manager.Manager'

Victory = class('manager.Victory', Manager)

function Victory:load()
    self.backgroundImage = love.graphics.newImage("assets/levelcomplete.png")
end

function Victory:keypressed(key, unicode)
    if key == "return" then
       -- start next level
    end
end

function Victory:draw()
    love.graphics.draw(self.backgroundImage, 0, 0)
end

return Victory
