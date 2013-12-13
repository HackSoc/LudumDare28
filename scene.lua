local HC = require 'HardonCollider'

entities = {}
hitboxes = {}
background = nil

function initialize()
   collider = HC(100, onCollide)
end

function onCollide(dt, hitbox1, hitbox2, dx, dy)
   local entity1 = hitboxes[hitbox1]
   local entity2 = hitboxes[hitbox2]

   if entity1.dead or entity2.dead then
      return
   end

   entity1:hit(entity2, dx, dy)
   entity2:hit(entity1, dx, dy)
end

function update(dt)
   for entity in entities do
      entity:update(dt)
   end

   collider:update(dt)

   for entity in entities do
      if entity.dead then
         removeDeadEntity(entity)
      end
   end
end

function removeDeadEntity(entity)
   table.remove(entities, entity)
   table.remove(hitboxes, entity.hitbox)
   HC.remove(entity.hitbox)
end

function draw()
   love.graphics.draw(background, 0, 0)

   for entity in entities do
      entity:draw()
   end
end

function addEntity(entity)
   entities[entity] = entity
   hitboxes[entity.hitbox] = entity
end
