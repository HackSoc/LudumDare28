require 'entity'
require 'ball'
require 'paddle'
local scene = require 'scene'

local paddleA = nil;
local paddleB = nil;
local ball = nil;

function love.load()
	success = love.graphics.setMode(800,600, false, true,0)
	scene.initialize()

	local ball = love.graphics.newImage("ball.png")

	paddleA = Paddle:new(90, 250, scene.collider)
	paddleB = Paddle:new(710, 250, scene.collider)
	ball = Ball:new(410, 210, ball, scene.collider)

	wallBottom = Wall:new(400, 625, 800, 50, scene.collider)
	wallTop = Wall:new(400, -25, 800, 50, scene.collider)

	scene.addEntity(paddleA)
	scene.addEntity(paddleB)
	scene.addEntity(ball)
	scene.addEntity(wallTop)
	scene.addEntity(wallBottom)
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


