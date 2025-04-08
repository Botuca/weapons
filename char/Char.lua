local love = require("love")
local Projectile = require("projectile/Projectile")
local Char = {}

Char.__index = Char

function Char.new(name, atk_speed, x, y)
    local self = setmetatable({}, Char)

    self.name = name
    self.x = x
    self.y = y
    self.atk_speed = 1 / atk_speed;
    self.projectiles = {}
    self.alarm = 0

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
    for i = #self.projectiles, 1, -1 do
        self.projectiles[i]:update(dt)

        if self.projectiles[i].x > _G.width then
            table.remove(self.projectiles, i)
        end
    end

    self.alarm = self.alarm + dt
    if self.alarm >= self.atk_speed then
        self:shoot()
        self.alarm = 0
    end
end

function Char:shoot()
    table.insert(self.projectiles, Projectile.new(self.x + 20, self.y + 20))
end

return Char