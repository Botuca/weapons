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
    local width_st = 500
    local height_st = 250
    local x_st = _G.width - width_st
    local offset_st = 30
    local y_st = offset_st

    love.graphics.setColor(0, 0, 0, 0.5)
    love.graphics.rectangle("fill", x_st, y_st, width_st - offset_st, height_st, 10)
    love.graphics.setColor(1, 1, 1)

    local offset_text = 20
    for i = 1, #self.skills, 1 do
        local x_skill_name = x_st + offset_text
        local y_skill_name = offset_text + i * 40
        love.graphics.print(self.skills[i].name .. " (lvl: ".. self.skills[i].level ..")", x_skill_name, y_skill_name)

        local width_btn = 120
        local height_btn = 30
        local x_btn = x_st + 330
        local y_btn = y_skill_name
        love.graphics.setColor(0, 0.65, 0)
        love.graphics.rectangle("fill", x_btn, y_skill_name, width_btn, height_btn, 10)
        love.graphics.setColor(1, 1, 1)

        local x_btn_text = x_btn + width_btn
        local y_btn_text = y_btn + 3
        love.graphics.print("BUY", x_btn_text, y_btn_text)
    end
end

return SkillTree