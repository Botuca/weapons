local Button = require("UI/hud/Button")
local Hud = {}
Hud.__index = Hud

function Hud.new()
    local self = setmetatable({}, Hud)

    self.imgs = Hud.create(self)

    return self
end

function Hud:update(dt)
    self.imgs.btn_shoot:update()
end

function Hud:create()
    return {
        btn_shoot = Button.new(
            10,
            _G.height - 40,
            "assets/sprites/spr_box_shoot.png",
            "SHOOT",
            function()
                _G.chars[1]:shoot()
            end
        ),
    }
end

function Hud:draw()
    self.imgs.btn_shoot:draw()
end

function Hud:mousepressed(x, y, button)
    self.imgs.btn_shoot:mousepressed(x, y, button)
end

return Hud

