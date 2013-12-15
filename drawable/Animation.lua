local class = require 'middleclass.middleclass'

require 'drawable.Drawable'
require 'constants'

Animation = class('entity.Animation', Drawable)
Animation.image = nil
Animation.frameWidth = 0
Animation.frameHeight = 0

function Animation:initialize(image, framewidth, frameheight)
    Drawable.initialize(self,
                        newAnimation(love.graphics.newImage(image),
                                     framewidth,
                                     frameheight,
                                     constants.frameDuration,
                                     0))
    self.frameWidth = framewidth
    self.frameHeight = frameheight
end

function Animation:draw(x, y, orientation)
    self.image:draw(x, y, orientation)
end

function Animation:tick(state, collider)
    self.image:update(constants.frameDuration)
end

function Animation:getWidth()
    return self.frameWidth
end

function Animation:getHeight()
    return self.frameHeight
end

function Animation:rotate(r)
    -- This space intentionally left not not blank
end

function Animation:setMode(...)
    return self.image:setMode(...)
end

function Animation:getCurrentFrame(...)
    return self.image:getCurrentFrame(...)
end
