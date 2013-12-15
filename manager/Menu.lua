class = require 'middleclass.middleclass'
require 'manager.Manager'
require 'manager.Game'

Menu = class('manager.Menu', Manager)

function Menu:load()
    self.backgroundImage = love.graphics.newImage("assets/menu.png")
    self.helpImage = love.graphics.newImage("assets/menu2.png")
    self.main = true
end

function Menu:keypressed(key, unicode)
    if self.main then
        if key == "return" then
            self.setManager(Game:new("testmap.tmx",
                                     setManager, love.load))
        elseif key == "f1" then
            self.main = false
        end
    else
        if key == "return" then
            self.main = true
        end
    end
end

function Menu:draw()
    if self.main then
        love.graphics.draw(self.backgroundImage, 0, 0)
    else
        love.graphics.draw(self.helpImage, 0, 0)
    end
end

return Menu
