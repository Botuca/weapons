local love = require("love")

local Debugs = {}

function Debugs.draw()
    for i, char in ipairs(_G.chars) do
        local y = 60
        local x = 0

        if i == 1 then
            x = 10
        else 
            x = i * 150
        end

        love.graphics.print("Char #" .. i, x, 50)

        local offset = 15
        for k, v in pairs(char) do
            love.graphics.print(k .. ": " .. tostring(v), x, y + offset)
            offset = offset + 15
        end
    end
end

return Debugs