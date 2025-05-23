local Button = require("src/UI/hud/Button")
local WeaponStore = require("src/UI/hud/weapon_store/WeaponStore")
local Hud = {}
Hud.__index = Hud

function Hud.new()
    local self = setmetatable({}, Hud)

    self.btn_shoot = Button.new(
        10,
        _G.height - 40,
        "assets/sprites/spr_box_shoot.png",
        "SHOOT",
        function()
            _G.chars[1]:shoot()
        end
    )
    self.weapon_store = WeaponStore.new()

    return self
end

function Hud:update(dt)
    self.btn_shoot:update()
end

function Hud:draw()
    self.btn_shoot:draw()
    self.weapon_store:draw()
end

function Hud:mousepressed(x, y, button)
    self.btn_shoot:mousepressed(x, y, button)
end

return Hud

