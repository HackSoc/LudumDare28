local class = require 'middleclass.middleclass'

require 'entity.bullet'
require 'entity.player'
require 'entity.tile'
require 'drawable.drawable'

EnemyBullet = class('entity.EnemyBullet', Bullet)
EnemyBullet.static.sprite = newSprite("assets/orange-bullet.png")

function EnemyBullet:initialize(id, x, y, collider, dir)
    Bullet.initialize(self, id, x, y, self.class.sprite, collider, dir)
end

function EnemyBullet:hit(other, dx, dy)
    if other:isInstanceOf(Player) then
        other:damage(self.class.damage)
        return true
    end

    if other:isInstanceOf(Tile) then
        return true
    end
end
