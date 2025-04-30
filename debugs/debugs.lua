local love = require("love")

local Debugs = {}

function Debugs.draw()
    love.graphics.setColor(0, 0, 0)
    for i, char in ipairs(_G.chars) do
        local y = 60
        local x = 0

        if i == 1 then
            x = 10
        else 
            x = i * 150
        end

        love.graphics.print("Char #" .. i, x, 50)

        local offset = 20
        for k, v in pairs(char) do
            love.graphics.print(k .. ": " .. tostring(v), x, y + offset)
            offset = offset + 20
        end
    end
    love.graphics.setColor(1, 1, 1)
end

return Debugs