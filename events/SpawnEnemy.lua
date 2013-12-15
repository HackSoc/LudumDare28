local class = require 'middleclass.middleclass'

require 'events.Event'
require 'entity.Enemy'
require 'utils'

SpawnEnemy = class('events.SpawnEnemy', Event)
SpawnEnemy.x = 0
SpawnEnemy.y = 0
SpawnEnemy.behaviour = {}

function SpawnEnemy:initialize(x,y)
    self.enemyId = uniqueId()
    self.x = x
    self.y = y
    self:createBehaviour()
end

function SpawnEnemy:createBehaviour()
    self.behaviour = {}
    for i = 1, 100 do
        self.behaviour[i] = math.random(0,10)
    end
end

function SpawnEnemy:apply(state, collider)
    local enemy = Enemy:new(self.enemyId, self.x, self.y, self.behaviour, collider)
    state[self.enemyId] = enemy
end
