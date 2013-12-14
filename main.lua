require 'entity.Entity'
require 'entity.Ball'
require 'entity.Paddle'
require 'entity.OneBullet'

require 'entity.Player'
local scene = require 'scene'

function love.load()
    love.graphics.setMode(800,600, false, true,0)
    love.graphics.setCaption("You only get one")
    scene.initialize()

    player = Player:new(90, 250, scene.collider)
    
    --Frank Add
    bullet = OneBullet:new(scene.collider)
    scene.addEntity(bullet)
    
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
    if key == 'w' then
        keyUp = true
    elseif key == 's' then
        keyDown = true
    elseif key == 'k' then
        bullet:goLeft()
    elseif key == 'l' then
        bullet:goRight()
    end
    if key == 'a' then
        keyLeft = true
    elseif key == 'd' then
        keyRight = true
    end
    
end

function love.keyreleased(key, unicode)
    if key == 'w' then
        keyUp = false
    elseif key == 's' then
        padDown = false
    elseif key == 'k' then
        bullet:stopLeft()
    elseif key == 'l' then
        bullet:stopRight()
    elseif key == 'a' then
        keyLeft = false
    elseif key == 'd' then
        keyRight = false
    end
end


function love.draw()
    scene.draw()
    
end
