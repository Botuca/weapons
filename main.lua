local love = require("love")
local Target = require("src/classes/target/Target")
local Save = require("save_load")
local LoadChars = require("src/classes/char/load_chars")
local Debugs = require("debugs/debugs")
local Background = require("src/UI/background/background")
local SkillTree = require("src/systems/skill_tree/SkillTree")
local Audio = require("audio")
local Hud = require("src/UI/hud/Hud")

_G.audio = Audio.new()
_G.bg = {}
_G.target = {}
_G.chars = {}
_G.height = love.graphics.getHeight();
_G.width = love.graphics.getWidth();
_G.player = {
    gold = 0,
    gold_per_hit = 1,
}

function love.load()
    math.randomseed(os.time())

    _G.audio:load("wood_hit", "assets/sounds/wood_hit.wav")

    _G.small_font = love.graphics.newFont(14)
    _G.font = love.graphics.newFont(20)
    _G.large_font = love.graphics.newFont(40)
    love.graphics.setFont(_G.font)

    _G.hud = Hud.new()

    _G.bg = Background.new()
    _G.world = love.physics.newWorld(0, 0, true)
    _G.world:setCallbacks(beginContact)
    _G.skillTree = SkillTree.new()

    _G.groundBody = love.physics.newBody(_G.world, 400, _G.height, "static")
    _G.groundShape = love.physics.newRectangleShape(_G.width, 50)
    _G.groundFixture = love.physics.newFixture(groundBody, groundShape)

    _G.target = Target.new((_G.width - 450) - 50, _G.height - 75, 25)
    _G.chars = LoadChars:loadChars()

    Save:loadGame()
end

function love.update(dt)
    dt = math.min(dt, 0.033)
    _G.bg:update(dt)
    _G.world:update(dt)
    _G.hud:update(dt)

    for i = 1, #_G.chars, 1 do
        _G.chars[i]:update(dt)
    end
end

function love.draw()
    love.graphics.rectangle("fill",
        _G.groundBody:getX() - 400, _G.groundBody:getY() - 25,
        _G.width, 50
    )

    _G.bg:draw()
    _G.hud:draw()
    _G.target:draw()
    _G.skillTree:draw()

    for i = 1, #_G.chars, 1 do
        _G.chars[i]:draw()
    end

    love.graphics.setColor(0, 0, 0)
    love.graphics.print("Gold: " ..tonumber(string.format("%.2f", _G.player.gold)), 10, 10)
    love.graphics.print("Gold per hit: " .._G.player.gold_per_hit, 10, 30)
    --love.graphics.print("Atk. speed: ".._G.chars[1].atk_speed, 10, 50)
    --love.graphics.print("Proj. speed: ".._G.chars[1].projectile_speed, 10, 70)
    --love.graphics.print("Crit rate: ".._G.chars[1].crit_rate.."%", 10, 90)
    --love.graphics.print("Crit damage: ".._G.chars[1].crit_dmg.."%", 10, 110)
    love.graphics.setColor(1, 1, 1)
    -- Debugs.draw()
end

---@diagnostic disable-next-line: lowercase-global
function beginContact(a, b, coll)
    local objA = a:getUserData()
    local objB = b:getUserData()

    if not objA or not objB then return end

    if (objA.type == 'projectile' and objB.type == 'target') or
       (objB.type == 'projectile' and objA.type == 'target') then

        local proj = objA.type == 'projectile' and objA or objB

        _G.audio:play("wood_hit")
        if proj.is_crit_hit then
            _G.player.gold = (_G.player.gold + (_G.player.gold_per_hit * proj.crit_dmg / 100))
        else
            _G.player.gold = _G.player.gold + _G.player.gold_per_hit
        end

        proj.projectileBody:destroy()
    end
end

function love.keypressed(key)
    if key == "s" then
        Save:saveGame()
    end

    if key == "g" then
        _G.player.gold = _G.player.gold + 100000
    end
end

function love.mousepressed(x, y, button)
    if _G.skillTree then
        _G.skillTree:mousepressed(x, y, button)
    end

    _G.hud:mousepressed(x, y, button)
end

if arg[2] == "debug" then
    require("lldebugger").start()
end