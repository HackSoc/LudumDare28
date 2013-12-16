local class = require 'middleclass.middleclass'

require 'entity.bullet'
require 'entity.enemy'
require 'entity.tile'
require 'drawable.drawable'

PlayerBullet = class('entity.PlayerBullet', Bullet)
PlayerBullet.static.sprite = newSprite("assets/blue-bullet.png")
PlayerBullet.static.speed = Bullet.static.speed * 3

function PlayerBullet:initialize(id, x, y, collider, dir)
    Bullet.initialize(self, id, x, y, self.class.sprite, collider, dir)
end

function PlayerBullet:hit(other, dx, dy)
    if other:isInstanceOf(Enemy) then
        other:damage(self.class.damage)
        return true
    end

    if other:isInstanceOf(Tile) then
        return true
    end
end
