local love = require("love")
local Target = {}
Target.__index = Target

function Target.new(x, y, radius)
    local self = setmetatable({}, Target)

    self.x = x
    self.y = y
    self.radius = radius
    self.ballBody = love.physics.newBody(_G.world, self.x, self.y, "static")
    self.ballShape = love.physics.newCircleShape(self.radius)
    self.ballFixture = love.physics.newFixture(self.ballBody, self.ballShape, 1)
    self.ballFixture:setUserData(self)
    self.type = 'target'

    return self
end

function Target:draw()
    love.graphics.circle("fill", self.ballBody:getX(), self.ballBody:getY(), self.ballShape:getRadius())
end

return Target