local constants = require 'constants'
local atl = require 'Advanced-Tiled-Loader'
local class = require 'middleclass.middleclass'

require 'manager.manager'
require 'manager.gameover'
require 'manager.levelcomplete'

require 'events.rightevent'
require 'events.leftevent'
require 'events.stopevent'
require 'events.playerbulletevent'
require 'events.spawnplayer'
require 'events.destroyevent'
require 'events.spawnenemy'
require 'events.jumpevent'
require 'events.tileevent'
require 'events.tilenocollisionevent'

require 'viewport'
require 'eventlog'
require 'utils'

local loader = atl.Loader
loader.path = "maps/"

Game = class('manager.Game', Manager)

-- Display
Game.bgimage = nil
Game.map = nil
Game.viewport = nil

-- Time
Game.time = 0
Game.realTime = 0
Game.maxTime = constants.playTime

-- Controls
Game.fireCooldown = 0
Game.movingLeft = false
Game.movingRight = false

-- State
Game.state = nil
Game.nextX = 0
Game.nextY = 0
Game.nextOrient = 1

-- Player
Game.playerId = nil

-- Framerate
Game.frame = 0
Game.frameDrawPercentage = 0.5
Game.frameMiniCount = 0

function Game:initialize(level, levelNum, ...)
    Manager.initialize(self, ...)
    self.level = level
    self.levelNum = levelNum
end

function Game:load()
    -- Create a viewport the size of the screen
    self.viewport = Viewport:new(constants.windowWidth, constants.windowHeight)

    -- Create the event log
    self.eventLog = EventLog:new({})

    -- Load in the map
    self.bgimage = self.level.background
    self.map = loader.load(self.level.mapfile)

    for x, y, tile in self.map("Objects"):iterate() do
        self.eventLog:append(TileNoCollisionEvent:new(x * self.map.tileWidth,
                                                      y * self.map.tileWidth, tile))
    end

    for x, y, tile in self.map("Map"):iterate() do
        self.eventLog:append(TileEvent:new(x * self.map.tileWidth,
                                           y * self.map.tileWidth, tile))
    end

    self.viewport.maxPan = self.map.width * self.map.tileWidth - (constants.windowWidth + self.map.tileWidth) / 2

    -- Create a new player
    local splayer = SpawnPlayer(100, 260, 1)
    self.playerId = splayer.playerId
    self.eventLog:append(splayer)

    -- Spawn some enemies
    self.eventLog:append(SpawnEnemy:new(1500,0))
    self.eventLog:append(SpawnEnemy:new(1400,0))
    self.eventLog:append(SpawnEnemy:new(1200,0))
    self.eventLog:append(SpawnEnemy:new(1000,0))
end

function Game:update(dt)
    local timeChanged = false
    
    --Frame Rate Limit
    self.realTime = self.realTime + dt
    if self.realTime > 0.5 then
       self.realTime = 0
       
       if self.frame > constants.framerate / 2 then
           self.frameDrawPercentage = constants.framerate / (2 * self.frame)
       end

       self.frame = 0
    end
    
    self.frame = self.frame + 1
    self.frameMiniCount = self.frameMiniCount + 1
    
    if self.frameMiniCount + math.random() <= 1 / self.frameDrawPercentage then
        -- Too many frames: skip this one
        return
    end

    self.frameMiniCount = 0

    -- Framerate corrected: continue.
    self.time = self.time + 1
        
    if self.state[self.playerId] and self.state[self.playerId].health <= 0 then
        -- Player is dead.
        self.setManager(GameOver:new(setManager, love.load))
        return
    end

    if self.state[self.playerId] ~= nil and self.state[self.playerId].y > 800 then
        --Falling Death
        self.setManager(GameOver:new(setManager, love.load))
        return
    end

    if self.fireCooldown > 0 then
        -- Let player fire more
        self.fireCooldown = self.fireCooldown - 1
    end

    if self.maxTime - self.time == constants.jumpTime then
        -- Record position of next player to be spawned
        self.nextX = self.state[self.playerId].x
        self.nextY = self.state[self.playerId].y
        self.nextOrient = self.state[self.playerId].orientation
    end

    if self.time > self.maxTime then
        -- Send player back in time
        self.eventLog:insert(DestroyEvent:new(self.playerId), self.time)

        self.maxTime = self.maxTime + constants.playTime - constants.jumpTime
        self.time = self.time - constants.jumpTime

        local splayer = SpawnPlayer(self.nextX, self.nextY, self.nextOrient)
        self.playerId = splayer.playerId
        self.eventLog:insert(splayer, self.time)

        -- Have the new player be moving when they spawn if they currently are now
        if self.movingLeft then
            self.eventLog:insert(LeftEvent:new(self.playerId), self.time + 1)
        elseif self.movingRight then
            self.eventLog:insert(RightEvent:new(self.playerId), self.time + 1)
        end
    end

    if self.time % 100 == 0 then
        -- Spawn a new enemy
        self.eventLog:insert(SpawnEnemy:new(self.state[self.playerId].x + 500,0),
                             self.maxTime + 1)
    end

    if self.state[self.playerId] and self.state[self.playerId].x > self.map.width * self.map.tileWidth - self.level.endpoint then
        -- Player has passed the victory point
        self.setManager(LevelComplete:new(self.levelNum, self.setManager, self.restart))
    end
end


function Game:keypressed(key, unicode)
    -- Space has no symbolic name :(
    if key == ' ' then
        key = "space"
    end

    if self.state[self.playerId] then
        if constants.controls.jump[key] then
            self.eventLog:insert(JumpEvent:new(self.playerId), self.time)
        elseif constants.controls.left[key] then
            self.eventLog:insert(LeftEvent:new(self.playerId), self.time)
            self.movingLeft = true
        elseif constants.controls.right[key] then
            self.eventLog:insert(RightEvent:new(self.playerId), self.time)
            self.movingRight = true
        elseif constants.controls.shoot[key] and self.fireCooldown <= 0 then
            self.eventLog:insert(PlayerBulletEvent:new(self.playerId, self.state[self.playerId].orientation), self.time)
            self.fireCooldown = 5
        end
    end
end

function Game:keyreleased(key, unicode)
    if self.state[self.playerId] then
        if constants.controls.left[key] then
            self.eventLog:insert(StopEvent:new(self.playerId), self.time)
            self.movingLeft = false
        elseif constants.controls.right[key] then
            self.eventLog:insert(StopEvent:new(self.playerId), self.time)
            self.movingRight = false
        end
    end
end

function Game:draw()
    -- Replay the event log
    self.state = self.eventLog:play(self.time)

    -- Move the viewport
    if self.state[self.playerId] then
        self.viewport:move(self.state[self.playerId].x, 300)
    end

    -- Draw the world
    love.graphics.draw(self.bgimage)
    self.viewport:draw(self.state)

    -- Draw the time bar
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
