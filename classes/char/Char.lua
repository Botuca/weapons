local love = require("love")
local Projectile = require("classes/projectile/Projectile")
local Char = {}

Char.__index = Char

function Char.new(name, target, x, y, atk_speed, projectile_speed, crit_rate, crit_dmg)
    local self = setmetatable({}, Char)

    self.name = name
    self.x = x
    self.y = y
    self.atk_speed = atk_speed;
    self.projectiles = {}
    self.time = 0
    self.target = target
    self.projectile_speed = projectile_speed
    self.crit_rate = crit_rate
    self.crit_dmg = crit_dmg
    self.sprite = love.graphics.newImage("assets/chars/archer.png")

    return self
end

function Char:draw()
    local scale = 0.08
    local sprite_width = self.sprite:getWidth()
    local sprite_height = self.sprite:getHeight()
    local sprite_origin_x = sprite_width / 2
    local sprite_origin_y = sprite_height / 2

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(
        self.sprite,
        self.x,
        _G.height - self.y,
        0,
        scale,
        scale,
        sprite_origin_x,
        sprite_origin_y
    )

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
    local is_crit_hit = Char.isCriticalHit(self)

    table.insert(self.projectiles, Projectile.new(self.x + 20, _G.height - self.y, self.target, self.projectile_speed, is_crit_hit, self.crit_dmg))
end

function Char.isCriticalHit(self)
    local chance = math.random() * 100

    return chance < self.crit_rate
end

return Char