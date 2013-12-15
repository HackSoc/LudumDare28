require 'manager.Menu'

io.stdout:setvbuf("no")
manager = nil

function love.load()
    love.window.setMode(800,600)
    love.window.setTitle("You Only Get Juan")

    restart()
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
    manager = newManager(setManager, restart)
    manager:load()
end

function restart()
    setManager(Menu)
end