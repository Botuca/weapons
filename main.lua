local love = require("love")
local Target = require("classes/target/Target")
local Save = require("save_load")
local LoadChars = require("classes/char/load_chars")
local Debugs = require("debugs/debugs")

_G.target = {}
_G.chars = {}
_G.height = love.graphics.getHeight();
_G.width = love.graphics.getWidth();
_G.player = {
    gold = 0
}

function love.load()
    _G.world = love.physics.newWorld(0, 0, true)
    _G.world:setCallbacks(beginContact)

    _G.groundBody = love.physics.newBody(_G.world, 400, _G.height, "static")
    _G.groundShape = love.physics.newRectangleShape(_G.width, 50)
    _G.groundFixture = love.physics.newFixture(groundBody, groundShape)

    _G.target = Target.new(_G.width - 50, _G.height - 50, 25)
    _G.chars = LoadChars:loadChars()

    Save:loadGame()
end

function love.update(dt)
    dt = math.min(dt, 0.033)
    world:update(dt)

    for i = 1, #_G.chars, 1 do
        _G.chars[i]:update(dt)
    end
end

function love.draw()
    love.graphics.rectangle("fill",
        groundBody:getX() - 400, groundBody:getY() - 25,
        _G.width, 50
    )

    _G.target:draw()

    for i = 1, #_G.chars, 1 do
        _G.chars[i]:draw()
    end

    love.graphics.print("Gold: " .._G.player.gold)
    Debugs.draw()
end

---@diagnostic disable-next-line: lowercase-global
function beginContact(a, b, coll)
    local objA = a:getUserData()
    local objB = b:getUserData()

    if not objA or not objB then return end

    if (objA.type == 'projectile' and objB.type == 'target') or
       (objB.type == 'projectile' and objA.type == 'target') then

        local proj = objA.type == 'projectile' and objA or objB

        _G.player.gold = _G.player.gold + 1

        proj.hit = true
        proj.projectileBody:destroy()
    end
end

function love.keypressed(key)
    if key == "s" then
        Save:saveGame()
    end
end

if arg[2] == "debug" then
    require("lldebugger").start()
end