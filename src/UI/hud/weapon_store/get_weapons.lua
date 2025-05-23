local json = require("lib/dkjson")

local GetWeapons = {}

function GetWeapons.load(path_file)
    local data = love.filesystem.read(path_file)
    local decoded = json.decode(data)

    if decoded then
        return decoded.weapons
    else
        return {}
    end
end

return GetWeapons