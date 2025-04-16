local love = require("love")
local Projectile = require("classes/projectile/Projectile")
local Char = {}

Char.__index = Char

function Char.new(name, target, x, y, atk_speed, projectile_speed)
    local self = setmetatable({}, Char)

    self.name = name
    self.x = x
    self.y = y
    self.atk_speed = atk_speed;
    self.projectiles = {}
    self.time = 0
    self.target = target
    self.projectile_speed = projectile_speed

    return self
end

function Char:draw()
    love.graphics.rectangle('fill', self.x, _G.height - self.y, 20, 50)

    if(self.projectiles[1]) then
        love.graphics.print(self.projectiles[1].speed, self.x, _G.height - self.y - 15)
    end

    for i = 1, #self.projectiles, 1 do
        self.projectiles[i]:draw()
    end
    
end

function Char:update(dt)
    self.time = self.time + dt
    if self.time >= 1 / self.atk_speed then
        self:shoot()

        for i = #self.projectiles, 1, -1 do
            if self.projectiles[i].hit then
                table.remove(self.projectiles, i)
            end
        end

        self.time = 0
    end
end

function Char:shoot()
    table.insert(self.projectiles, Projectile.new(self.x + 20, _G.height - self.y  + 20, self.target, self.projectile_speed))
end

return Char