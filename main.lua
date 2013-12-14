require 'entity.Entity'
require 'entity.Ball'
require 'entity.Paddle'
local scene = require 'scene'

function love.load()
    love.graphics.setMode(800,600, false, true,0)
    love.graphics.setCaption("Ping Pong")
    scene.initialize()

    paddleA = Paddle:new(90, 250, scene.collider)
    paddleB = Paddle:new(710, 250, scene.collider)
    ball = Ball:new(410, 210, scene.collider)

    wallTop = Wall:new(400, -25, 800, 50, scene.collider)
    wallBottom = Wall:new(400, 625, 800, 50, scene.collider)

    scene.addEntity(paddleA)
    scene.addEntity(paddleB)
    scene.addEntity(ball)
    scene.addEntity(wallTop)
    scene.addEntity(wallBottom)
end


function love.update(dt)
    if paddleB.y < ball.y then
        paddleB:moveDown()
    else
        paddleB:moveUp()
    end
    if padUp then
        paddleA:moveUp()
    elseif padDown then
        paddleA:moveDown()
    end
    scene.update(dt)
end


function love.keypressed(key, unicode)
    if key == 'up' then
        padUp = true
    elseif key == 'down' then
        padDown = true
    end
end

function love.keyreleased(key, unicode)
    if key == 'up' then
        padUp = false
    elseif key == 'down' then
        padDown = false
    end
end


function love.draw()
    scene.draw()
    
end
