local scene = {}

local HC = require 'HardonCollider'

scene.entities = {}
scene.hitboxes = {}
scene.background = love.graphics.newImage("background.png")

function scene.initialize()
   collider = HC(100, onCollide)
end

function scene.onCollide(dt, hitbox1, hitbox2, dx, dy)
   local entity1 = hitboxes[hitbox1]
   local entity2 = hitboxes[hitbox2]

   if entity1.dead or entity2.dead then
      return
   end

   entity1:hit(entity2, dx, dy)
   entity2:hit(entity1, dx, dy)
end

function scene.update(dt)
   for key, entity in pairs(scene.entities) do
      entity:update(dt)
   end

   collider:update(dt)

   for key, entity in pairs(scene.entities) do
      if entity.dead then
         scene.removeDeadEntity(entity)
      end
   end
end

function scene.removeDeadEntity(entity)
   table.remove(scene.entities, entity)
   table.remove(scene.hitboxes, entity.hitbox)
   HC.remove(entity.hitbox)
end

function scene.draw()
   love.graphics.draw(scene.background, 0, 0)

   for key,entity in pairs(scene.entities) do
      entity:draw()
   end
end

function scene.addEntity(entity)
   scene.entities[entity] = entity
   scene.hitboxes[entity.hitbox] = entity
end

return scene
