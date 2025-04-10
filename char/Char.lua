local love = require("love")
local Projectile = require("projectile/Projectile")
local Char = {}

Char.__index = Char

function Char.new(name, x, y, atk_speed, target)
    local self = setmetatable({}, Char)

    self.name = name
    self.x = x
    self.y = y
    self.atk_speed = 1 / atk_speed;
    self.projectiles = {}
    self.alarm = 0
    self.target = target

    return self
end

function Char:draw()
    love.graphics.rectangle('fill', self.x, self.y, 20, 50)

    for i = 1, #self.projectiles, 1 do
        self.projectiles[i]:draw()
    end
end

function Char:update(dt)
    self.alarm = self.alarm + dt
    if self.alarm >= self.atk_speed then
        self:shoot()

        for i = #self.projectiles, 1, -1 do
            if self.projectiles[i].hit then
                table.remove(self.projectiles, i)
            end
        end
        
        self.alarm = 0
    end
end

function Char:shoot()
    table.insert(self.projectiles, Projectile.new(self.x + 20, self.y + 20, self.target, 500))
end

return Char