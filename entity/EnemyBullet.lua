local class = require 'middleclass.middleclass'
require 'entity.Bullet'
require 'entity.Player'

EnemyBullet = class('entity.EnemyBullet', Bullet)
EnemyBullet.static.sprite = love.graphics.newImage("assets/orange-bullet.png")

function EnemyBullet:hit(other, dx, dy)
    if other.class == Player then
        other:damage(self.class.damage)
        return true
    end
end
