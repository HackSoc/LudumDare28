local class = require 'middleclass.middleclass'
require 'entity.Bullet'
require 'entity.Player'

EnemyBullet = class('entity.EnemyBullet', Bullet)
EnemyBullet.static.sprite = love.graphics.newImage("assets/orange-bullet.png")
EnemyBullet.static.speed = -5

function EnemyBullet:hit(other, dx, dy)
    Bullet.hit(self, other, dx, dy)
    if other.class == Player then
        other:damage(self.class.damage)
    end
end
