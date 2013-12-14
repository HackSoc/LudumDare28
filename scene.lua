local scene = {}

local HC = require 'HardonCollider'

scene.callbacks = {}
scene.entities = {}
scene.hitboxes = {}
scene.background = love.graphics.newImage("assets/background.png")

function scene.initialize()
    scene.collider = HC(100, scene.onCollide)
end

function scene.onCollide(dt, hitbox1, hitbox2, dx, dy)
    local entity1 = scene.hitboxes[hitbox1]
    local entity2 = scene.hitboxes[hitbox2]

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

    scene.collider:update(dt)

    for key, entity in pairs(scene.entities) do
        if entity.dead then
            scene.removeDeadEntity(entity)
        end
    end

    for key, callback in pairs(scene.callbacks) do
        callback(scene, dt)
    end
end

function scene.addCallback(callback)
    table.insert(scene.callbacks, callback)
end

function scene.removeDeadEntity(entity)
    scene.entities[entity] = nil
    scene.hitboxes[entity.hitbox] = nil
    scene.collider:remove(entity.hitbox)
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
