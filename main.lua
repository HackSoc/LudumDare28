require 'entity.Entity'
<<<<<<< HEAD
require 'entity.Ball'
require 'entity.Paddle'
require 'entity.OneBullet'

=======
require 'entity.Player'
>>>>>>> f0c799003b54a0ac5e692487557ee0a3953c4360
local scene = require 'scene'

function love.load()
    love.graphics.setMode(800,600, false, true,0)
    love.graphics.setCaption("You only get one")
    scene.initialize()

    player = Player:new(90, 250, scene.collider)

<<<<<<< HEAD
    wallTop = Wall:new(400, -25, 800, 50, scene.collider)
    wallBottom = Wall:new(400, 625, 800, 50, scene.collider)

    scene.addEntity(paddleA)
    scene.addEntity(paddleB)
    scene.addEntity(ball)
    scene.addEntity(wallTop)
    scene.addEntity(wallBottom)
    
    --Frank Add
    bullet = OneBullet:new(scene.collider)
    scene.addEntity(bullet)
    
=======
    scene.addEntity(player)
>>>>>>> f0c799003b54a0ac5e692487557ee0a3953c4360
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
<<<<<<< HEAD
        padDown = true
    elseif key == 'k' then
        bullet:goLeft()
    elseif key == 'l' then
        bullet:goRight()
=======
        keyDown = true
    end
    if key == 'left' then
        keyLeft = true
    elseif key == 'right' then
        keyRight = true
>>>>>>> f0c799003b54a0ac5e692487557ee0a3953c4360
    end
    
end

function love.keyreleased(key, unicode)
    if key == 'up' then
        keyUp = false
    elseif key == 'down' then
<<<<<<< HEAD
        padDown = false
    elseif key == 'k' then
        bullet:stopLeft()
    elseif key == 'l' then
        bullet:stopRight()
=======
        keyDown = false
    end
    if key == 'left' then
        keyLeft = false
    elseif key == 'right' then
        keyRight = false
>>>>>>> f0c799003b54a0ac5e692487557ee0a3953c4360
    end
end


function love.draw()
    scene.draw()
    
end
