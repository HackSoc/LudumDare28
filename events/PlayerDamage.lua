local class = require 'middleclass.middleclass'

require 'events.EntityEvent'
require 'utils'

PlayerDamage = class('events.PlayerDamage', EntityEvent)

function PlayerDamage:initialize(damage)
    self.entityId = uniqueId()
    self.damage = damage
    print "Create Player Damage"
end

function PlayerDamage:apply(state, collider)
    print "Apply Player Damage"
    if state.playerHealth == nil then
       state.playerHealth = Player.maxHealth --Begin with Max Health 
    end
    state.playerHealth = state.playerHealth - self.damage
end
