local class = require 'middleclass.middleclass'

require 'events.event'
require 'entity.enemy'
require 'utils'

SpawnEnemy = class('events.SpawnEnemy', Event)
SpawnEnemy.x = 0
SpawnEnemy.y = 0
SpawnEnemy.behaviour = nil

function SpawnEnemy:initialize(x,y)
    self.enemyId = uniqueId()
    self.x = x
    self.y = y
    self:createBehaviour()
end

function SpawnEnemy:createBehaviour()
    self.behaviour = {}
    for i = 0, 99 do
        self.behaviour[i] = math.random(0,10)
    end
end

function SpawnEnemy:apply(state, collider)
    local enemy = Enemy:new(self.enemyId,
                            self.x,
                            self.y,
                            self.behaviour,
                            collider)

    state[self.enemyId] = enemy
end
