local class = require 'middleclass.middleclass'

Level = class('Level')
Level.mapfile = nil
Level.background = nil
Level.endpoint = 0

function Level:initialize(mapfile, background, endpoint)
    self.mapfile = mapfile .. ".tmx"
    self.background = love.graphics.newImage("assets/" .. background)
    self.endpoint = endpoint
end
