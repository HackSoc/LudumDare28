class = require 'middleclass.middleclass'
require 'manager.Manager'

Game = class('manager.Game', Manager)

require 'manager.GameOver'

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
require 'events.JumpEvent'

require 'Display'
require 'EventLog'

require 'utils'

Game.static.playTime = 140
Game.static.jumpTime = 100
Game.static.frameDuration = 1 / 25

Game.startState = {}

Game.interval = 0
Game.time = 0
Game.maxTime = Game.static.playTime
Game.fireCooldown = 0
Game.keyUp = false
Game.keyDown = false
Game.keyLeft = false
Game.keyRight = false
Game.state = {}
Game.nextX = 0
Game.nextY = 0
Game.playerId = nil

function Game:load()
    self.display = Display:new()

    self.eventLog = EventLog:new(self.startState)

    local bgEvents = self.display.class.background:getEvents()
    for _, v in ipairs(bgEvents) do
        self.eventLog:append(v)
    end

    local splayer = SpawnPlayer(100, 260)
    self.playerId = splayer.playerId
    self.eventLog:append(splayer)

    self.eventLog:append(SpawnEnemy:new(600,400))
    self.eventLog:append(SpawnEnemy:new(500,400))
    self.eventLog:append(SpawnEnemy:new(400,400))
end

function Game:update(dt)
    local timeChanged = false
    self.interval = self.interval + dt
    while (self.interval > self.class.frameDuration) do
        self.interval = self.interval - self.class.frameDuration
        self.time = self.time + 1
        self.eventLog:append(TickEvent:new())
        if self.fireCooldown > 0 then
            self.fireCooldown = self.fireCooldown - 1
        end
        if self.maxTime - self.time == self.class.jumpTime then
            self.nextX = self.state[self.playerId].x
            self.nextY = self.state[self.playerId].y
        end
    end

    if self.state[self.playerId] ~= nil and self.state[self.playerId].health <= 0 then
        self.setManager(GameOver)
        return
    end

    if self.time > self.maxTime then
        self.eventLog:insert(DestroyEvent:new(self.playerId), self.time)

        self.maxTime = self.maxTime + self.class.playTime - self.class.jumpTime
        self.time = self.time - self.class.jumpTime

        local splayer = SpawnPlayer(self.nextX, self.nextY)
        self.playerId = splayer.playerId
        self.eventLog:insert(splayer, self.time)
    end

    if self.time % 50 == 0 then
        self.eventLog:append(SpawnEnemy:new(self.nextX + 600,200))
    end
end


function Game:keypressed(key, unicode)
    if key == 'w' then
        self.keyUp = true
        self.eventLog:insert(JumpEvent:new(self.playerId), self.time)
    elseif key == 's' then
        self.keyDown = true
    elseif key == 'a' and self.keyLeft == false then
        self.eventLog:insert(LeftEvent:new(self.playerId), self.time)
        self.keyLeft = true
    elseif key == 'd' and self.keyRight == false then
        self.eventLog:insert(RightEvent:new(self.playerId), self.time)
        self.keyRight = true
    elseif key == ' ' and self.fireCooldown <= 0 then
        self.eventLog:insert(PlayerBulletEvent:new(self.playerId, self.state[self.playerId].orientation), self.time)
        self.fireCooldown = 5
    elseif key == '-' then
        self.eventLog:insert(EnemyBulletEvent:new(self.playerId, self.state[self.playerId].orientation), self.time)
    end
end

function Game:keyreleased(key, unicode)
    if key == 'w' then
        self.keyUp = false
    elseif key == 's' then
        self.keyDown = false
    elseif key == 'a' and self.keyLeft == true then
        self.eventLog:insert(StopEvent:new(self.playerId), self.time)
        self.keyLeft = false
    elseif key == 'd' and self.keyRight == true then
        self.eventLog:insert(StopEvent:new(self.playerId), self.time)
        self.keyRight = false
    end
end

function Game:draw()
    self.state = self.eventLog:play(self.time)
    self.display:draw(self.state)

    drawFilledBar(580, 20, 200, 20,
                  (self.maxTime - self.time) / self.class.playTime,
                  {107,141,255}, nil, {255,255,255})

    resetDraw(
        function ()
            love.graphics.setColor(255, 255, 255)

            local str = math.ceil((self.maxTime - self.time) * self.class.frameDuration)
            local strWidth = love.graphics.getFont():getWidth(str)
            love.graphics.print(str, 680 - strWidth/2, 23)
        end)
end

return Game
