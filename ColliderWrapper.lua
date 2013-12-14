local class = require 'middleclass.middleclass'
local HC = require 'HardonCollider'

ColliderWrapper = class('ColliderWrapper')

function ColliderWrapper:initialize()
    self.collider = HC(100, self.onCollide)
    self.hitboxes = {}
end

function ColliderWrapper:onCollide(dt, hitbox1, hitbox2, dx, dy)
    --print("Collision")
end

function ColliderWrapper:clear(...)
    return self.collider:clear(...)
end

function ColliderWrapper:update(...)
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
