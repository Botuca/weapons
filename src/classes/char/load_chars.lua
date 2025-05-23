local json = require("lib.dkjson")
local Char = require("src/classes/char/Char")

local LoadChars = {}

function LoadChars.loadChars()
    local data = love.filesystem.read("data/chars.json")
    local decoded = json.decode(data)
    local chars = {}

    for _, char in ipairs(decoded.chars or {}) do
        table.insert(chars, Char.new(char.name, _G.target, char.x, char.y, char.atk_speed, char.projectile_speed, char.crit_rate, char.crit_dmg))
    end

    return chars
end

return LoadChars