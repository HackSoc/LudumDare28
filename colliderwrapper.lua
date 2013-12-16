local class = require 'middleclass.middleclass'
local HC = require 'HardonCollider'

require 'events.eraseevent'

ColliderWrapper = class('ColliderWrapper')

-- number of ticks of slack/buffer to allow when erasing an event
-- theoretically, this should not be necessary, but using it guarantees
-- that we will not encounter hard-to-reproduce bugs due to off-by-one
-- errors on the order of milliseconds
ColliderWrapper.static.erasureSlack = 10

function ColliderWrapper:initialize(eventLog)
    self.collider = HC(100, function(...) self:onCollide(...) end)
    self.hitboxes = {}
    self.eventLog = eventLog
end

function ColliderWrapper:onCollide(dt, hitbox1, hitbox2, dx, dy)
    local id1 = self.hitboxes[hitbox1]
    local id2 = self.hitboxes[hitbox2]

    local entity1 = self.state[id1]
    local entity2 = self.state[id2]

    if entity1 == nil or entity2 == nil then
        if entity1 == nil then self:remove(hitbox1) end
        if entity2 == nil then self:remove(hitbox2) end

        return
    end

    if entity1:hit(entity2, dx, dy) then
        self.eventLog:insert(DestroyEvent(id1), self.time)
        self.eventLog:insert(EraseEvent(id1), self.time + constants.jumpTime + self.class.erasureSlack)
    end

    if entity2:hit(entity1, -dx, -dy) then
        self.eventLog:insert(DestroyEvent(id2), self.time)
        self.eventLog:insert(EraseEvent(id2), self.time + constants.jumpTime + self.class.erasureSlack)
    end
end

function ColliderWrapper:clear(...)
    return self.collider:clear(...)
end

function ColliderWrapper:tick(time, state)
    self.state = state
    self.time = time
    return self.collider:update(0)
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

function ColliderWrapper:addPolygon(entityid, ...)
    local hitbox = self.collider:addPolygon(...)
    self.hitboxes[hitbox] = entityid
    return hitbox
end

function ColliderWrapper:setGhost(x)
    pcall(function() self.collider:setGhost(x) end)
end

function ColliderWrapper:setSolid(x)
    pcall(function() self.collider:setSolid(x) end)
end
