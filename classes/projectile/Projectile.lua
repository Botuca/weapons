local love = require("love")
local Projectile = {}
Projectile.__index = Projectile

function Projectile.new(x, y, target, projectile_speed, is_crit_hit, crit_dmg)
    local self = setmetatable({}, Projectile)

    self.x = x
    self.y = y
    self.projectile_speed = projectile_speed
    self.target = target
    self.projectileBody = love.physics.newBody(_G.world, self.x, self.y, "dynamic")
    self.projectileShape = love.physics.newRectangleShape(30, 5)
    self.projectileFixture = love.physics.newFixture(self.projectileBody, self.projectileShape, 1)
    self.projectileFixture:setUserData(self)
    self.projectileFixture:setCategory(2)
    self.projectileFixture:setMask(2)
    self.speed = _G.width / (1 / self.projectile_speed)
    self.projectileBody:setLinearVelocity(self.speed, 0)
    self.type = 'projectile'
    self.img = love.graphics.newImage("assets/arrows/1.png")
    self.is_crit_hit = is_crit_hit
    self.crit_dmg = crit_dmg

    return self
end

function Projectile:draw()
    if not self.projectileBody:isDestroyed() then
        local imgW = self.img:getWidth()
        local imgH = self.img:getHeight()
        love.graphics.draw(self.img, self.projectileBody:getX(), self.projectileBody:getY(), 0, .2, .15, imgW / 2, imgH / 2)
    end
end

function Projectile:ifHitTarget()
    return self.x >= self.target.x - self.target.radius
end

return Projectile
