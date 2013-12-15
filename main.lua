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
require 'events.SpawnEnemy'

require 'Display'
require 'EventLog'


require 'utils'

startState = {}

interval = 0
time = 0
maxTime = 140
fireCooldown = 0
keyLeft = false
keyRight = false
state = {}
age = 0
nextX = 0
nextY = 0

function love.load()
    love.graphics.setMode(800,600, false, true,0)
    love.graphics.setCaption("You Only Get Juan")
    
    display = Display:new()

    eventLog = EventLog:new(startState)

    bgEvents = display.class.background:getEvents()
    for _, v in ipairs(bgEvents) do
        eventLog:append(v)
    end

    local splayer = SpawnPlayer(100, 460)
    playerId = splayer.playerId
    eventLog:append(splayer)
    eventLog:append(SpawnEnemy:new(600,400))
    eventLog:append(SpawnEnemy:new(500,400))
    eventLog:append(SpawnEnemy:new(400,400))
end

function love.update(dt)
    local timeChanged = false
    interval = interval + dt
    if (interval > 0.02) then
        interval = 0
        time = time + 1
        eventLog:append(TickEvent:new())
        if fireCooldown > 0 then
            fireCooldown = fireCooldown - 1
        end
        age = age + 1
        if age == 40 then
            nextX = state[playerId].x
            nextY = state[playerId].y
        end
    end

    if time > maxTime then
        eventLog:insert(DestroyEvent:new(playerId), time)

        maxTime = maxTime + 40
        time = time - 100

        age = 0

        local splayer = SpawnPlayer(nextX, nextY)
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
    elseif key == ' ' and fireCooldown <= 0 then
        eventLog:insert(PlayerBulletEvent:new(playerId, state[playerId].orientation), time)
        fireCooldown = 20
    elseif key == '-' then
        eventLog:insert(EnemyBulletEvent:new(playerId, state[playerId].orientation), time)
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
    state = eventLog:play(time)
    display:draw(state)
end
