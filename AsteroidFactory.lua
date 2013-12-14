require 'entity.Asteroid'

local AsteroidFactory = {}

AsteroidFactory.max = 5

function AsteroidFactory.callback(scene, dt)
   local asteroids = 0
   for key, entity in pairs(scene.entities) do
      if entity.class == Asteroid then
         asteroids = asteroids + 1
      end
   end
   while asteroids < AsteroidFactory.max do
       AsteroidFactory.spawn(scene)
       asteroids = asteroids + 1
   end
end

function AsteroidFactory.spawn(scene)
   local asteroid = Asteroid:new(math.random(800), math.random(600), math.random(-20,20), math.random(-20,20), scene.collider)
   scene.addEntity(asteroid)
end   

return AsteroidFactory
