require 'entity.Entity'
require 'entity.Block'
local HC = require 'HardonCollider'

require 'Scene'

entities = {}

function love.load()
    love.graphics.setMode(800,600, false, true,0)
    love.graphics.setCaption("You Only Get Juan")
    
    scene = Scene:new()

    collider = HC(100, onCollide)

    blk1 = Block:new(100, 100, collider)
    blk2 = Block:new(140, 100, collider)

    entities[blk1] = blk1
    entities[blk2] = blk2
end

function onCollide(dt, hitbox1, hitbox2, dx, dy)

end

function love.update(dt)

end


function love.keypressed(key, unicode)
    if key == 'w' then
        keyUp = true
    elseif key == 's' then
        keyDown = true
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
        bullet:stopRight()
    elseif key == 'a' then
        keyLeft = false
    elseif key == 'd' then
        keyRight = false
    end
end


function love.draw()
    scene:draw(entities)
end
