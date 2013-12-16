local class = require 'middleclass.middleclass'
require 'manager.manager'

Victory = class('manager.Victory', Manager)

function Victory:load()
    self.backgroundImage = love.graphics.newImage("assets/youwin.png")
end

function Victory:keypressed(key, unicode)
    if key == "return" then
       self.setManager(Menu:new(setManager, love.load))
    end
end

function Victory:draw()
    love.graphics.draw(self.backgroundImage, 0, 0)
end

return Victory
