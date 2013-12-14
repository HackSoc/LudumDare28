require 'entity.Entity'
require 'entity.Ball'
require 'entity.Paddle'
require 'entity.OneBullet'
require 'entity.Asteroid'

require 'entity.Player'
local scene = require 'scene'

function love.load()
    love.graphics.setMode(800,600, false, true,0)
    love.graphics.setCaption("You only get one")
    scene.initialize()

    player = Player:new(90, 250, scene.collider)
    
    wallLeft = Wall:new(-100, 300, 50, 600, scene.collider)
    wallRight = Wall:new(900, 300, 50, 600, scene.collider)
    wallTop = Wall:new(400, -100, 800, 50, scene.collider)
    wallBottom = Wall:new(400, 700, 800, 50, scene.collider)

    scene.addEntity(wallLeft)
    scene.addEntity(wallRight)
    scene.addEntity(wallTop)
    scene.addEntity(wallBottom)
    
    --Frank Add
    bullet = OneBullet:new(scene.collider)
    scene.addEntity(bullet)
    
    scene.addEntity(player)

    --add Asteroids
    asteroid1 = Asteroid:new(300, 500, 100, 100, scene.collider)
    asteroid2 = Asteroid:new(460, 180, 100, -100, scene.collider)
    asteroid3 = Asteroid:new(220, 330, -100, -100, scene.collider)
    scene.addEntity(asteroid1)
    scene.addEntity(asteroid2)
    scene.addEntity(asteroid3)
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
    elseif key == 'a' then
        keyLeft = true
    elseif key == 'd' then
        keyRight = true
    end
    
end

function love.keyreleased(key, unicode)
    if key == 'w' then
        keyUp = false
    elseif key == 's' then
        keyDown = false
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
