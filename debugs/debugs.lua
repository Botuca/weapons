local love = require("love")

local Debugs = {}

function Debugs.draw()
    for _, char in _G.chars, 1 do
        love.graphics.print(char.name)
    end
end

return Debugs