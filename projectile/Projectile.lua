local love = require("love")
local Projectile = {}
Projectile.__index = Projectile

function Projectile.new(x, y, target)
    local self = setmetatable({}, Projectile)

    self.x = x
    self.y = y
    self.speed = 500
    self.target = target
    self.hit = false

    return self
end

function Projectile:update(dt)
    self.x = self.x + self.speed * dt

    if self.ifHitTarget(self) then
        _G.player.gold = _G.player.gold + 1;
        self.hit = true;
    end
end

function Projectile:draw()
    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle("fill", self.x, self.y, 30, 5)
    love.graphics.setColor(1, 1, 1)
end

function Projectile:ifHitTarget()
    return self.x >= self.target.x - self.target.radius 
end

return Projectile
