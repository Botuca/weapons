local SkillsData = {
    ["gold_per_hit"] = {
        name = "Gold/hit",
        description = "1.0 increased gold per hit",
        cost = function(level) return 10 * (1.5 ^ level) end,
        apply = function(level)
            _G.player.gold_per_hit = _G.player.base_gold_per_hit + (level * 1.0)
        end
    },
    ["atk_speed"] = {
        name = "Atk. speed",
        description = "0.2 increased attack speed",
        cost = function(level) return 10 * (1.6 ^ level) end,
        apply = function(level, index)
            _G.chars[index].atk_speed = _G.chars[index].base_atk_speed + (level * 0.2)
        end
    },
    ["projectile_speed"] = {
        name = "Proj. speed",
        description = "0.2 increased projectile speed",
        cost = function(level) return 10 * (1.6 ^ level) end,
        apply = function(level, index)
            _G.chars[index].projectile_speed = _G.chars[index].base_projectile_speed + (level * 0.2)
        end
    },
    ["crit_rate"] = {
        name = "Crit. rate",
        description = "0.2 increased critical rate",
        cost = function(level) return 10 * (1.7 ^ level) end,
        apply = function(level, index)
            _G.chars[index].crit_rate = _G.chars[index].base_crit_rate + (level * 0.2)
        end
    },
    ["crit_dmg"] = {
        name = "Crit. damage",
        description = "5 increased critical damage",
        cost = function(level) return 10 * (1.8 ^ level) end,
        apply = function(level, index)
            _G.chars[index].crit_dmg = _G.chars[index].base_crit_dmg + (level * 5)
        end
    }
}

return SkillsData
