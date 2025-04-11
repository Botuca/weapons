local love = require("love")
local json = require("lib.dkjson")
local Char = require("char/Char")

local LoadChars = {}

function LoadChars.loadChars()
    local data = love.filesystem.read("char/chars.json")
    local decoded = json.decode(data)
    local chars = {}

    for _, char in ipairs(decoded.chars or {}) do
        table.insert(chars, Char.new(char.name, _G.target, char.x, char.y, char.atk_speed, char.projectile_speed))
    end

    return chars
end

return LoadChars