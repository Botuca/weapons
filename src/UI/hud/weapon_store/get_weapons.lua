local json = require("lib/dkjson")

local GetWeapons = {}

function GetWeapons.load(path_file)
    local data = love.filesystem.read(path_file)
    local decoded = json.decode(data)

    return decoded.weapons;
end

return GetWeapons