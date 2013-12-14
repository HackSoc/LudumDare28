local class = require 'middleclass.middleclass'
require 'entity.Bullet'

PlayerBullet = class('entity.PlayerBullet', Bullet)
PlayerBullet.static.speed = 25

function PlayerBullet:hit(other, dx, dy)
    Bullet.hit(self, other, dx, dy)
    -- If other is enemy, kill it
end
