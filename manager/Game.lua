class = require 'middleclass.middleclass'
require 'manager.Manager'

Game = class('manager.Game', Manager)

local constants = require 'constants'

require 'manager.GameOver'
require 'manager.Victory'

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

Game.startState = {}

Game.interval = 0
Game.time = 0
Game.maxTime = constants.playTime
Game.fireCooldown = 0
Game.keyUp = false
Game.keyDown = false
Game.keyLeft = false
Game.keyRight = false
Game.state = {}
Game.nextX = 0
Game.nextY = 0
Game.playerId = nil
Game.realTime = 0
Game.frame = 0
Game.frameDrawPercentage = 1.0
Game.frameMiniCount = 0

function Game:initialize(level, ...)
    Manager.initialize(self, ...)
    self.level = level
end

function Game:load()
    self.display = Display:new(self.level)

    self.eventLog = EventLog:new(self.startState)

    local bgEvents = self.display.background:getEvents()
    for _, v in ipairs(bgEvents) do
        self.eventLog:append(v)
    end

    local splayer = SpawnPlayer(100, 260, 1)
    Player.static.currentHealth = 100.0
    self.playerId = splayer.playerId
    self.eventLog:append(splayer)

    self.eventLog:append(SpawnEnemy:new(1500,200))
    self.eventLog:append(SpawnEnemy:new(1400,200))
    self.eventLog:append(SpawnEnemy:new(1200,200))
    self.eventLog:append(SpawnEnemy:new(1000,400))
end

function Game:update(dt)
    local timeChanged = false
    
    --Frame Rate Limit - 30 fps
    self.realTime = self.realTime + dt
    if self.realTime > 0.5 then
       self.realTime = 0.0
       
       if self.frame > (constants.framerate / 2.0) then
          self.frameDrawPercentage = (constants.framerate / 2.0) / self.frame
       end
       self.frame = 0.0
    end
    
    self.frame = self.frame + 1
    self.frameMiniCount = self.frameMiniCount + 1
    
    if (self.frameMiniCount + math.random() > (1.0 / self.frameDrawPercentage)) then
        self.frameMiniCount = 0
        
        
        self.time = self.time + 1

        
        if self.fireCooldown > 0 then
            self.fireCooldown = self.fireCooldown - 1
        end
        if self.maxTime - self.time == constants.jumpTime then
            self.nextX = self.state[self.playerId].x
            self.nextY = self.state[self.playerId].y
            self.nextOrient = self.state[self.playerId].orientation
        end

        if self.state[self.playerId] ~= nil and self.state[self.playerId].health <= 0 then
            self.setManager(GameOver:new(setManager, love.load))
            return
        end

        if self.time > self.maxTime then
            self.eventLog:insert(DestroyEvent:new(self.playerId), self.time)

            self.maxTime = self.maxTime + constants.playTime - constants.jumpTime
            self.time = self.time - constants.jumpTime

            local splayer = SpawnPlayer(self.nextX, self.nextY, self.nextOrient)
            self.playerId = splayer.playerId
            self.eventLog:insert(splayer, self.time)

            -- Not sure why this needs to be `time + 1`
            -- But `time` doesn't work.
            if self.keyLeft then
                self.eventLog:insert(LeftEvent:new(self.playerId), self.time + 1)
            elseif self.keyRight then
                self.eventLog:insert(RightEvent:new(self.playerId), self.time + 1)
            end
        end

        if self.time % 100 == 0 then
            self.eventLog:insert(SpawnEnemy:new(self.state[self.playerId].x+500,0), self.maxTime + 1)
        end
        
        if self.state[self.playerId] ~= nil and self.state[self.playerId].x > (self.display.background.map.width*self.display.background.map.tileWidth) - 140 then
            self.setManager(Victory)
        end
    end
end


function Game:keypressed(key, unicode)
    if self.state[self.playerId] then
        if key == 'w' or key == 'up' then
            self.keyUp = true
            self.eventLog:insert(JumpEvent:new(self.playerId), self.time)
        elseif key == 's' or key == 'down' then
            self.keyDown = true
        elseif (key == 'a' or key == 'left') and self.keyLeft == false then
            self.eventLog:insert(LeftEvent:new(self.playerId), self.time)
            self.keyLeft = true
        elseif (key == 'd' or key == 'right') and self.keyRight == false then
            self.eventLog:insert(RightEvent:new(self.playerId), self.time)
            self.keyRight = true
        elseif key == ' ' and self.fireCooldown <= 0 then
            self.eventLog:insert(PlayerBulletEvent:new(self.playerId, self.state[self.playerId].orientation), self.time)
            self.fireCooldown = 5
        elseif key == '-' then
            self.eventLog:insert(EnemyBulletEvent:new(self.playerId, self.state[self.playerId].orientation), self.time)
        end
    end
end

function Game:keyreleased(key, unicode)
    if self.state[self.playerId] then
        if key == 'w' or key == 'up' then
            self.keyUp = false
        elseif key == 's' or key == 'down' then
            self.keyDown = false
        elseif (key == 'a' or key == 'left') and self.keyLeft == true then
            self.eventLog:insert(StopEvent:new(self.playerId), self.time)
            self.keyLeft = false
        elseif (key == 'd' or key == 'right') and self.keyRight == true then
            self.eventLog:insert(StopEvent:new(self.playerId), self.time)
            self.keyRight = false
        end
    end
end

function Game:draw()
    self.state = self.eventLog:play(self.time)

    if self.state[self.playerId] then
        self.display:viewport(self.state[self.playerId].x, 300)
    end

    self.display:draw(self.state)

    drawFilledBar(580, 20, 200, 20,
                  (self.maxTime - self.time) / constants.playTime,
                  {107,141,255}, nil, {255,255,255})

    resetDraw(
        function ()
            love.graphics.setColor(255, 255, 255)

            local str = math.ceil((self.maxTime - self.time) / constants.framerate)
            local strWidth = love.graphics.getFont():getWidth(str)
            love.graphics.print(str, 680 - strWidth/2, 23)
        end)
end

return Game
