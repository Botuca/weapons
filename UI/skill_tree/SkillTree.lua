local love = require("love")
local SkillTree = {}
SkillTree.__index = SkillTree

function SkillTree.new(x, y, radius)
    local self = setmetatable({}, SkillTree)

    self.skills = {
        {
            name = "Gold per hit",
            description = "0.2 increased gold per hit",
            level = 0,
            cost = 10,
        },
        {
            name = "Attack speed",
            description = "0.2 increased attack speed",
            level = 0,
            cost = 100,
        },
        {
            name = "Projectile speed",
            description = "0.2 increased projectile speed",
            level = 0,
            cost = 300,
        },
        {
            name = "Critical rate",
            description = "0.2 increased critical rate",
            level = 0,
            cost = 500,
        },
        {
            name = "Critical damage",
            description = "5 increased critical damage",
            level = 0,
            cost = 800,
        }
    }

    return self
end

function SkillTree.draw(self)
    local st_width = 500
    local st_height = 250
    local st_x = _G.width - st_width
    local st_offset = 30
    local st_y = st_offset

    love.graphics.setColor(0, 0, 0, 0.5)
    love.graphics.rectangle("fill", st_x, st_y, st_width - st_offset, st_height, 10)
    love.graphics.setColor(1, 1, 1)

    local offset_text = 20
    for i = 1, #self.skills, 1 do
        local skill_name_x = st_x + offset_text
        local skill_name_y = offset_text + i * 40
        love.graphics.print(self.skills[i].name .. " (lvl: ".. self.skills[i].level ..")", skill_name_x, skill_name_y)

        local btn_width = 120
        local btn_height = 30
        local btn_x = st_x + 330
        local btn_y = skill_name_y
        love.graphics.setColor(0, 0.65, 0)
        love.graphics.rectangle("fill", btn_x, skill_name_y, btn_width, btn_height, 10)
        love.graphics.setColor(1, 1, 1)

        local btn_text = "BUY"
        local font = love.graphics.getFont()
        local btn_text_width = font:getWidth(btn_text)
        local btn_text_height = font:getHeight()
        local btn_text_x = btn_x + (btn_width - btn_text_width) / 2
        local btn_text_y = btn_y + (btn_height - btn_text_height) / 2
        
        love.graphics.print("BUY", btn_text_x, btn_text_y)
    end
end

return SkillTree