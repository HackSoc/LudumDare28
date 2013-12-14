require 'entity.Entity'
require 'entity.Player'
require 'events.TickEvent'
require 'events.RightEvent'
require 'events.LeftEvent'
require 'events.StopEvent'
require 'events.PlayerBulletEvent'
require 'events.EnemyBulletEvent'
require 'events.SpawnPlayer'
require 'events.DestroyEvent'

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

    eventLog = EventLog:new()

    bgEvents = display.class.background:getEvents()
    for _, v in ipairs(bgEvents) do
        eventLog:append(v)
    end

    local splayer = SpawnPlayer()
    playerId = splayer.playerId
    eventLog:append(splayer)
    state = startState
end

function love.update(dt)
    interval = interval + dt
    if (interval > 0.02) then
        interval = 0
        local oldTime = time
        time = time + 1
        eventLog:append(TickEvent:new())
        state = eventLog:partialApply(state, oldTime, time)
    end

    if time > maxTime then
        eventLog:insert(DestroyEvent:new(playerId), time)

        maxTime = maxTime + 40
        time = time - 100
        local splayer = SpawnPlayer()
        playerId = splayer.playerId
        eventLog:insert(splayer, time)
        state = eventLog:apply(startState, time)
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
    display:draw(state)
end
