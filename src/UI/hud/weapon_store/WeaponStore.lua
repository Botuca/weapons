local GetWeapons = require("src/UI/hud/weapon_store/get_weapons")
local WeaponStore = {}
WeaponStore.__index = WeaponStore

function WeaponStore.new()
    local self = setmetatable({}, WeaponStore)

    self.weapons = GetWeapons.load("src/UI/hud/weapon_store/weapons.json")

    return self
end

function WeaponStore:draw()
    for i = 1, #self.weapons, 1 do
        love.graphics.print(self.weapons[i].name, 200, 500 + (i * 30))
    end
end

return WeaponStore