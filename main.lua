require 'entity.Entity'
require 'entity.Block'
require 'entity.Player'
require 'events.PlayerBulletEvent'
require 'events.EnemyBulletEvent'
require 'events.SpawnPlayer'
local HC = require 'HardonCollider'

require 'Display'
require 'EventLog'


require 'utils'

startState = {}

interval = 0
time = 0
maxTime = 100
keyLeft = false
keyRight = false


function love.load()
    love.graphics.setMode(800,600, false, true,0)
    love.graphics.setCaption("You Only Get Juan")
    
    display = Display:new()

    collider = HC(100, onCollide)

    blk1 = Block:new(100, 500, collider)
    blk2 = Block:new(140, 500, collider)

    startState[uniqueId()] = blk1
    startState[uniqueId()] = blk2

    eventLog = EventLog:new()
    local splayer = SpawnPlayer(collider)
    playerId = splayer.playerId
    eventLog:append(splayer)
end

function onCollide(dt, hitbox1, hitbox2, dx, dy)
end

function love.update(dt)
    interval = interval + dt
    if (interval > 0.02) then
        interval = 0
        time = time + 1
        eventLog:append(TickEvent:new(collider))
    end

    if time > maxTime then
        eventLog:insert(DestroyEvent:new(playerId), time)

        maxTime = maxTime + 40
        time = time - 100
        local splayer = SpawnPlayer(collider)
        playerId = splayer.playerId
        eventLog:insert(splayer, time)
    end
end


function love.keypressed(key, unicode)
    if key == 'w' then
        keyUp = true
    elseif key == 's' then
        keyDown = true
    elseif key == 'a' and keyLeft == false then
        eventLog:insert(LeftEvent:new(playerId), time)
        keyLeft = true
    elseif key == 'd' and keyRight == false then
        eventLog:insert(RightEvent:new(playerId), time)
        keyRight = true
    elseif key == ' ' then
        eventLog:insert(PlayerBulletEvent:new(playerId), time)
    elseif key == '-' then
        eventLog:insert(EnemyBulletEvent:new(playerId), time)
    end
end

function love.keyreleased(key, unicode)
    if key == 'w' then
        keyUp = false
    elseif key == 's' then
        keyDown = false
    elseif key == 'a' and keyLeft == true then
        eventLog:insert(StopEvent:new(playerId), time)
        keyLeft = false
    elseif key == 'd' and keyRight == true then
        eventLog:insert(StopEvent:new(playerId), time)
        keyRight = false
    end
end


function love.draw()
    collider:clear()
    local state = eventLog:apply(startState, time)
    -- print "----"
    for _, v in ipairs(eventLog.events) do
        -- print(v.class.name)
    end
    display:draw(state)
end
