local class = require 'middleclass.middleclass'

require 'manager.manager'
require 'manager.victory'
require 'level'

LevelComplete = class('manager.LevelComplete', Manager)
LevelComplete.static.levels = {}
LevelComplete.static.levels[2] = Level:new("map2", "background.png", 140)
LevelComplete.static.levels[3] = Level:new("map3", "level1.png", 140)

function LevelComplete:initialize(level, ...)
    Manager.initialize(self, ...)
    self.nextLevel = level + 1
end

function LevelComplete:load()
    self.backgroundImage = love.graphics.newImage("assets/levelcomplete.png")
    if self.nextLevel == 4 then
    	self.setManager(Victory:new(setManager, love.load))
    end
end

function LevelComplete:keypressed(key, unicode)
    if key == "return" then
       self.setManager(Game:new(self.class.levels[self.nextLevel], self.nextLevel,
                                setManager, love.load))
    end
end

function LevelComplete:draw()
    love.graphics.draw(self.backgroundImage, 0, 0)
end

return LevelComplete
