local love = require("love")
local Projectile = {}
Projectile.__index = Projectile

function Projectile.new(x, y, target, projectile_speed)
    local self = setmetatable({}, Projectile)

    self.x = x
    self.y = y
    self.projectile_speed = projectile_speed
    self.target = target
    self.hit = false
    self.projectileBody = love.physics.newBody(_G.world, self.x, self.y, "dynamic")
    self.projectileShape = love.physics.newRectangleShape(30, 5)
    self.projectileFixture = love.physics.newFixture(self.projectileBody, self.projectileShape, 1)
    self.projectileFixture:setUserData(self)
    self.speed = _G.width / (1 / self.projectile_speed)
    self.projectileBody:setLinearVelocity(self.speed, 0)
    self.type = 'projectile'

    return self
end

function Projectile:draw()
    if not self.projectileBody:isDestroyed() then
        love.graphics.setColor(1, 0, 0)
        love.graphics.rectangle("fill", self.projectileBody:getX(), self.projectileBody:getY(), 30, 5)
        love.graphics.setColor(1, 1, 1)
    end
end

function Projectile:ifHitTarget()
    return self.x >= self.target.x - self.target.radius
end

return Projectile
