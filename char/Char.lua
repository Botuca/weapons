local love = require("love")
local Projectile = require("projectile/Projectile")
local Char = {}
Char.__index = Char

function Char.new(name)
    local self = setmetatable({}, Char)

    self.name = name
    self.x = 100
    self.y = _G.height - 100
    self.projectiles = {}

    return self
end

function Char:draw()
    love.graphics.rectangle('fill', self.x, self.y, 20, 50)
    love.graphics.print(self.name, self.x - 15, self.y + 60)

    for i = 1, #self.projectiles, 1 do
        self.projectiles[i]:draw()
    end
end

function Char:update(dt)
    for _, p in ipairs(self.projectiles) do
        p:update(dt)
    end
end

function Char:shoot()
    table.insert(projectiles, 1, Projectile.new(self.x, self.y))
end

return Char