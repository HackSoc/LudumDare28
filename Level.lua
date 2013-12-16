local class = require 'middleclass.middleclass'

Level = class('Level')
Level.mapfile = nil
Level.background = nil

function Level:initialize(mapfile, background)
    self.mapfile = mapfile .. ".tmx"
    self.background = love.graphics.newImage("assets/" .. background)
end
