require 'manager.Menu'

love.graphics.drawq = love.graphics.drawq or love.graphics.draw
io.stdout:setvbuf("no")
manager = nil

function love.load()
    setManager(Menu:new(setManager, love.load))
end

function love.update(dt)
    manager:update(dt)
end

function love.keypressed(key, unicode)
    manager:keypressed(key, unicode)
end

function love.keyreleased(key, unicode)
    manager:keyreleased(key, unicode)
end

function love.draw()
    manager:draw()
end

function setManager(newManager)
    manager = newManager
    manager:load()
end
