local love = require("love")
local Target = {}
Target.__index = Target

function Target.new()
    local self = setmetatable({}, Target)

    self.x = _G.width - 100
    self.y = _G.height - 75
    self.radius = 25
    self.ballBody = love.physics.newBody(world, self.x, self.y, "dynamic")
    self.ballShape = love.physics.newCircleShape(25)
    self.ballFixture = love.physics.newFixture(self.ballBody, self.ballShape, 1)

    return self
end

function Target:draw()
    love.graphics.circle("fill", self.ballBody:getX(), self.ballBody:getY(), self.ballShape:getRadius())
end

return Target