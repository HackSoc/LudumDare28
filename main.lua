require 'manager.Menu'

io.stdout:setvbuf("no")
manager = nil

function love.load()
    setManager(Menu)
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
    manager = newManager(setManager, love.load)
    manager:load()
end
