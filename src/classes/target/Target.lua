local love = require("love")
local Target = {}
Target.__index = Target

function Target.new(x, y, radius)
    local self = setmetatable({}, Target)

    self.x = x
    self.y = y
    self.radius = radius
    self.ballBody = love.physics.newBody(_G.world, self.x + 10, self.y, "static")
    self.ballShape = love.physics.newCircleShape(self.radius)
    self.ballFixture = love.physics.newFixture(self.ballBody, self.ballShape, 1)
    self.ballFixture:setUserData(self)
    self.ballFixture:setCategory(4)
    self.ballFixture:setMask()
    self.type = 'target'
    self.sprite = love.graphics.newImage("assets/images/targets/target.png")

    return self
end

function Target:draw()
    local scale = 0.08
    local rotation = 0
    local sprite_width = self.sprite:getWidth()
    local sprite_height = self.sprite:getHeight()
    local sprite_origin_x = sprite_width / 2
    local sprite_origin_y = sprite_height / 2

    love.graphics.draw(
        self.sprite,
        self.x,
        self.y,
        rotation,
        -scale,
        scale,
        sprite_origin_x,
        sprite_origin_y
    )
end

return Target