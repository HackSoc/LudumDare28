
local scene = require 'scene'
require 'entity'

function love.load()
	scene.initialize()
	paddleimg = love.graphics.newImage("paddle.png")
	
	paddleA = Entity:new(100,100,paddleimg,scene.collider)
	paddleB = Entity:new(500,100,paddleimg,scene.collider)
	scene.addEntity(paddleA)
	scene.addEntity(paddleB)
	
	print "Test"
	
end


function love.update(dt)
	scene.update(dt)
	
end


function love.keypressed(key, unicode)
	
	
end


function love.keyreleased(key, unicode)
	
end


function love.draw()
	scene.draw()
	
end	


