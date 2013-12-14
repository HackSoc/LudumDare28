require 'entity.Entity'
require 'entity.Block'
local HC = require 'HardonCollider'

require 'Display'
require 'EventLog'

require 'utils'

startState = {}

interval = 0
time = 0

function love.load()
    love.graphics.setMode(800,600, false, true,0)
    love.graphics.setCaption("You Only Get Juan")
    
    display = Display:new()

    collider = HC(100, onCollide)

    blk1 = Block:new(100, 100, collider)
    blk2 = Block:new(140, 100, collider)

    startState[uniqueId()] = blk1
    startState[uniqueId()] = blk2
    
    playerId = uniqueId()
    
    eventLog = EventLog()
end

function onCollide(dt, hitbox1, hitbox2, dx, dy)

end

function love.update(dt)
    interval = interval + dt
    if (interval > 0.05) then
        interval = 0
        time = time + 1
    end
end


function love.keypressed(key, unicode)
    if key == 'w' then
        keyUp = true
    elseif key == 's' then
        keyDown = true
    elseif key == 'a' and keyLeft == false then
        eventLog = eventLog:insert(LeftEvent(playerId))
        keyLeft = true
    elseif key == 'd' and keyRight == false then
        eventLog = eventLog:insert(RightEvent(playerId))
        keyRight = true
    end
    
end

function love.keyreleased(key, unicode)
    if key == 'w' then
        keyUp = false
    elseif key == 's' then
        keyDown = false
    elseif key == 'a' and keyLeft == true then
        eventLog = eventLog:insert(LeftEvent(playerId))
        keyLeft = false
    elseif key == 'd' and keyRight == false then
        eventLog = eventLog:insert(RightEvent(playerId))
        keyRight = false
    end
end


function love.draw()
    display:draw(eventLog:apply(startState, time))
end
