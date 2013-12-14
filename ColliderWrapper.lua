local class = require 'middleclass.middleclass'
local HC = require 'HardonCollider'

ColliderWrapper = class('ColliderWrapper')

function ColliderWrapper:initialize(eventlog)
    self.collider = HC(100, function(...) self:onCollide(...) end)
    self.hitboxes = {}
    self.eventlog = eventlog
end

function ColliderWrapper:onCollide(dt, hitbox1, hitbox2, dx, dy)
    local entity1 = self.state[self.hitboxes[hitbox1]]
    local entity2 = self.state[self.hitboxes[hitbox2]]

    entity1:hit(entity2, dx, dy)
    entity2:hit(entity1, -dx, -dy)
end

function ColliderWrapper:clear(...)
    return self.collider:clear(...)
end

function ColliderWrapper:update(state, ...)
    self.state = state
    return self.collider:update(...)
end

function ColliderWrapper:remove(hitbox)
    self.hitboxes[hitbox] = nil
    return self.collider:remove(hitbox)
end

function ColliderWrapper:addRectangle(entityid, ...)
    local hitbox = self.collider:addRectangle(...)
    self.hitboxes[hitbox] = entityid
    return hitbox
end
