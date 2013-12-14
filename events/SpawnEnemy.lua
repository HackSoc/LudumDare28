local class = require 'middleclass.middleclass'

require 'entity.Enemy'
require 'utils'

SpawnEnemy = class('events.SpawnEnemy', Event)
SpawnEnemy.x = 0
SpawnEnemy.y = 0

function SpawnEnemy:initialize(x,y)
    self.enemyId = uniqueId()
    self.x = x
    self.y = y
end

function SpawnEnemy:apply(state, collider)
    local enemy = Enemy:new(self.enemyId, self.x, self.y, collider)
    state[self.enemyId] = enemy
end