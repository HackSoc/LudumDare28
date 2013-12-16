local class = require 'middleclass.middleclass'

require 'entity.mob'
require 'entity.enemybullet'
require 'entity.explosion'
require 'drawable.drawable'
require 'utils'

Enemy = class('entity.Enemy', Mob)
Enemy.static.sprite = {}
Enemy.static.sprite[0] = newSprite("assets/monster-0.png")
Enemy.static.sprite[1] = newSprite("assets/monster-1.png")
Enemy.static.sprite[2] = newSprite("assets/monster-2.png")
Enemy.static.sprite[3] = newSprite("assets/monster-3.png")
Enemy.static.sprite[4] = newSprite("assets/monster-4.png")
Enemy.static.speed = 5

Enemy.maxHealth = 5
Enemy.internalTick = 0
Enemy.behaviour = nil
Enemy.bullets = nil
Enemy.exploded = false
Enemy.fireSound = nil
Enemy.deathSound = nil

function Enemy:initialize(id, x, y, behaviour, collider)
   Mob.initialize(self, id, x, y, self.class.sprite[behaviour[1]%5], collider)
   self.behaviour = behaviour
   self.bullets = {}

   self.fireSound = love.audio.newSource("sound/enemy-shoot.wav")
   self.deathSound = love.audio.newSource("sound/enemy-death.wav")

   -- All enemies start walking towards the left
   self:startLeft()
end


function Enemy:tick(state, collider)
    if self.visible == false then
        -- Explode on death
        if self.exploded then
            return
        end

        local id = uniqueId()
        local explosion = Explosion:new(id, self.x, self.y, collider)
        state[id] = explosion
        love.audio.stop(self.deathSound)
        love.audio.rewind(self.deathSound)
        table.insert(state["sfx"], self.deathSound)
        self.exploded = true
    end

    -- Maintain an internal clock
    self.internalTick = self.internalTick + 1

    -- Apparently random deterministic behaviour
    if self.internalTick % 4 == 0 then 
        selectBehaviour = (self.internalTick / 4) % 100

        if self.behaviour[selectBehaviour] < 4 then
            self:startLeft()
        elseif self.behaviour[selectBehaviour] == 4 then
            self:startRight()
        elseif self.behaviour[selectBehaviour] < 8 then
            self:jump()
        end
    end

    if self.internalTick % math.floor(8 / constants.speed) == 0 then
        -- Shoot every 8 ticks
        local id = uniqueId()
        local bullet = EnemyBullet:new(id, self.x, self.y, collider, self.orientation)
        state[id] = bullet
        love.audio.stop(self.fireSound)
        love.audio.rewind(self.fireSound)
        table.insert(state["sfx"], self.fireSound)
    end

    -- Tick mob
    Mob.tick(self)
end

