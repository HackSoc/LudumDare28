local class = require 'middleclass.middleclass'
require 'entity.Bullet'
require 'entity.Enemy'

PlayerBullet = class('entity.PlayerBullet', Bullet)
PlayerBullet.static.speed = 5

function PlayerBullet:hit(other, dx, dy)
    if other.class == Enemy then
        other:damage(self.class.damage)
        return true
    end
end
