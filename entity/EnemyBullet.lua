local class = require 'middleclass.middleclass'
require 'entity.Bullet'
require 'entity.Player'
require 'entity.Tile'

EnemyBullet = class('entity.EnemyBullet', Bullet)
EnemyBullet.static.sprite = love.graphics.newImage("assets/orange-bullet.png")

function EnemyBullet:initialize(id, x, y, collider, dir)
    Bullet.initialize(self, id, x, y, self.class.sprite, collider, dir)
end

function EnemyBullet:hit(other, dx, dy)
    if other.class == Player then
        other:damage(self.class.damage)
        return true
    end
    if other.class == Tile then
        return true
    end
end
