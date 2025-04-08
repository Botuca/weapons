local love = require("love")
local Projectile = {}
Projectile.__index = Projectile

function Projectile.new(x, y)
    local self = setmetatable({}, Projectile)

    self.x = x
    self.y = y

    return self
end

function Projectile:update(dt)
    self.x = self.x * dt
end

function Projectile:draw()
    love.graphics.rectangle("fill", self.x, self.y, 50, 10)
end

return Projectile
