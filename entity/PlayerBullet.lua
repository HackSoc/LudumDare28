local class = require 'middleclass.middleclass'
require 'entity.Bullet'
require 'entity.Enemy'

PlayerBullet = class('entity.PlayerBullet', Bullet)
PlayerBullet.static.sprite = love.graphics.newImage("assets/blue-bullet.png")


function PlayerBullet:initialize(id, x, y, collider, dir)
    Bullet.initialize(self, id, x, y, self.class.sprite, collider, dir)
end


function PlayerBullet:hit(other, dx, dy)
    if other.class == Enemy then
        other:damage(self.class.damage)
        return true
    end
end
