local class = require 'middleclass.middleclass'

Manager = class('manager.Manager')
Manager.setManager = nil

function Manager:initialize(setManager)
    self.setManager = setManager
end

function Manager:load()
end

function Manager:update(dt)
end

function Manager:keypressed(key, unicode)
end

function Manager:keyreleased(key, unicode)
end

function Manager:draw()
end

return Manager
