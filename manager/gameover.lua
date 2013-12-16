local class = require 'middleclass.middleclass'

require 'manager.manager'

GameOver = class('manager.GameOver', Manager)

function GameOver:load()
    self.backgroundImage = love.graphics.newImage("assets/gameover.png")
end

function GameOver:keypressed(key, unicode)
    if key == "return" then
        self.restart()
    end
end

function GameOver:draw()
    love.graphics.draw(self.backgroundImage, 0, 0)
end

return GameOver
