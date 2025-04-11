local love = require("love")
local json = require("lib.dkjson")
local Char = require("char/Char")
local LoadChars = require("char/load_chars")

local Save = {}

function Save.createSaveData()
    local saveData = {
        gold = _G.player.gold,
        chars = {}
    }

    for i = 1, #_G.chars, 1 do
        table.insert(saveData.chars, {
            name = _G.chars[i].name,
            x = _G.chars[i].x,
            y = _G.chars[i].y,
            atk_speed = _G.chars[i].atk_speed,
            projectile_speed = _G.chars[i].projectile_speed
        })
    end

    return saveData
end

function Save.saveGame()
    local data = json.encode(Save.createSaveData(), { indent = true })
    love.filesystem.write("savegame.json", data)
    print("[SAVE] Jogo salvo.")
end

function Save.loadGame()
    if love.filesystem.getInfo("savegame.json") then
        local data = love.filesystem.read("savegame.json")
        local decoded = json.decode(data)

        _G.player.gold = decoded.gold or 0
        _G.chars = {}

        for _, char in ipairs(decoded.chars or {}) do
            table.insert(chars, Char.new(char.name, _G.target, char.x, char.y, char.atk_speed, char.projectile_speed))
        end

        print("[LOAD] Jogo carregado.")
    else
        _G.chars = LoadChars:loadChars()
    end
end

return Save