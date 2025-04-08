local love = require("love")
local Projectile = {}
Projectile.__index = Projectile

function Projectile.new(x, y)
    local self = setmetatable({}, Projectile)

    self.x = x
    self.y = y
    self.speed = 500

    return self
end

function Projectile:update(dt)
    self.x = self.x + self.speed * dt
end

function Projectile:draw()
    love.graphics.rectangle("fill", self.x, self.y, 30, 5)
end

return Projectile
