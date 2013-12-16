class = require 'middleclass.middleclass'
require 'manager.Manager'

Victory = class('manager.Victory', Manager)

function Victory:load()
    self.backgroundImage = love.graphics.newImage("assets/levelcomplete.png")
end

function Victory:keypressed(key, unicode)
    if key == "return" then
       self.setManager(Game:new(Level:new("map2", "background.png", 140),
                                setManager, love.load))
    end
end

function Victory:draw()
    love.graphics.draw(self.backgroundImage, 0, 0)
end

return Victory
