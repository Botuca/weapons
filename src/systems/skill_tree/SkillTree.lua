local PassivesTree = require("data.passives_tree")
local SkillTree = {}
SkillTree.__index = SkillTree

function SkillTree.new(x, y, radius)
    local self = setmetatable({}, SkillTree)

    self.buttons  = {}

    return self
end

function SkillTree.applyAllSkills(run_data, player_index)
    for skill_id, level in pairs(run_data.skill_tree_levels) do
        local skill = PassivesTree[skill_id]
        if skill and skill.apply then
            skill.apply(level, player_index)
        end
    end
end

function SkillTree.draw(self)
    -- Draw skill tree box
    local skill_tree_width = 500
    local skill_tree_height = 210
    local skill_tree_x = _G.width - skill_tree_width
    local skill_tree_offset = 10
    local skill_tree_y = skill_tree_offset
    local skill_tree_radius = 10

    love.graphics.setColor(0, 0, 0, 0.5)
    love.graphics.rectangle("fill", skill_tree_x, skill_tree_y, skill_tree_width - skill_tree_offset, skill_tree_height, skill_tree_radius)
    love.graphics.setColor(1, 1, 1)

    -- Draw upgrades
    local offset_text_box_x = skill_tree_offset + 5
    local offset_text_box_y = skill_tree_offset + 13
    local offset_text = 40
    for i = 1, #PassivesTree, 1 do
        -- Draw upgrades names and lvl 
        local skill_name_x = skill_tree_x + offset_text_box_x
        local skill_name_y = offset_text_box_y + ((i - 1) * offset_text)
        love.graphics.print(self.skills[i].name .. " (".. self.skills[i].level ..")", skill_name_x, skill_name_y)

        -- Draw buy button
        local btn_width = 60
        local btn_height = 30
        local btn_x = _G.width - (skill_tree_offset * 2) - btn_width
        local btn_y = skill_name_y - 3

        if _G.player.gold >= self.skills[i].cost then
            love.graphics.setColor(0, 0.65, 0)
        else
            love.graphics.setColor(0.65, 0, 0)
        end

        love.graphics.rectangle("fill", btn_x, btn_y, btn_width, btn_height, 10)
        love.graphics.setColor(1, 1, 1)

        self.buttons[i] = {
            x = btn_x,
            y = btn_y,
            width = btn_width,
            height = btn_height,
            index = i
        }

        -- Draw buy button centered text
        love.graphics.setFont(_G.small_font)
        local btn_text = "BUY"
        local font = love.graphics.getFont()
        local btn_text_width = font:getWidth(btn_text)
        local btn_text_height = font:getHeight()
        local btn_text_x = btn_x + (btn_width - btn_text_width) / 2
        local btn_text_y = btn_y + (btn_height - btn_text_height) / 2

        love.graphics.print("BUY", btn_text_x, btn_text_y)

        -- Draw cost text
        local cost_text = string.format("$ %.2f", self.skills[i].cost)
        local cost_text_x = skill_tree_x + (skill_tree_width / 1.6)
        local cost_text_y = btn_text_y

        love.graphics.print(cost_text, cost_text_x, cost_text_y)
        love.graphics.setFont(_G.font)
    end
end

function SkillTree:mousepressed(x, y, button)
    if button ~= 1 then return end

    for _, btn in ipairs(self.buttons) do
        if x >= btn.x and x <= btn.x + btn.width and y >= btn.y and y <= btn.y + btn.height then
            local skill = self.skills[btn.index]

            if _G.player.gold >= skill.cost then
                _G.player.gold = _G.player.gold - skill.cost

                skill.level = skill.level + 1
                skill.cost = skill.cost * 1.5

                local archer_index = 1
                skill.event(archer_index)
            end
        end
    end
end

return SkillTree