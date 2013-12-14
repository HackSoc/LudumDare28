require 'entity.Entity'
require 'entity.Player'
local scene = require 'scene'

function love.load()
    love.graphics.setMode(800,600, false, true,0)
    love.graphics.setCaption("Ping Pong")
    scene.initialize()

    player = Player:new(90, 250, scene.collider)

    scene.addEntity(player)
end


function love.update(dt)
    if keyUp then
        player:moveUp()
    elseif keyDown then
        player:moveDown()
    end
    if keyLeft then
        player:moveLeft()
    elseif keyRight then
        player:moveRight()
    end
    scene.update(dt)
end


function love.keypressed(key, unicode)
    if key == 'up' then
        keyUp = true
    elseif key == 'down' then
        keyDown = true
    end
    if key == 'left' then
        keyLeft = true
    elseif key == 'right' then
        keyRight = true
    end
end

function love.keyreleased(key, unicode)
    if key == 'up' then
        keyUp = false
    elseif key == 'down' then
        keyDown = false
    end
    if key == 'left' then
        keyLeft = false
    elseif key == 'right' then
        keyRight = false
    end
end


function love.draw()
    scene.draw()
    
end
