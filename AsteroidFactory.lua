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
   dx = math.random(-300,300)
   dy = math.random(-300,300)

   local edge = math.random(4) --North, East, South, West
   if edge == 1 then
      x = math.random(800)
      y = math.random(100)
   elseif edge == 2 then
      x = 800 - math.random(100)
      y = math.random(600)
   elseif edge == 3 then
      x = math.random(800)
      y = 600 - math.random(100)
   else
      x = math.random(100)
      y = math.random(600)
   end
   
   local asteroid = Asteroid:new(x, y, dx, dy, scene.collider)
   scene.addEntity(asteroid)
end   

return AsteroidFactory
