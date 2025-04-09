local love = require("love")
local Target = {}
Target.__index = Target

function Target.new()
    local self = setmetatable({}, Target)

    self.x = _G.width - 100
    self.y = _G.height - 75
    self.radius = 25

    return self
end

function Target:draw()
    love.graphics.circle("fill", self.x, self.y, self.radius);
end

return Target