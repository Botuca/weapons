local love = require("love")
local Char = require("char/Char")
local Target = require("target/Target")

local chars = {}
local target = {}

_G.height = love.graphics.getHeight();
_G.width = love.graphics.getWidth();
_G.player = {
    gold = 0
}

function love.load()
    _G.world = love.physics.newWorld(0, 0, true)
    _G.world:setCallbacks(beginContact)

    _G.groundBody = love.physics.newBody(_G.world, 400, _G.height, "static")
    _G.groundShape = love.physics.newRectangleShape(800, 50)
    _G.groundFixture = love.physics.newFixture(groundBody, groundShape)

    target = Target.new(_G.width - 50, _G.height - 50, 25)

    table.insert(chars, 1, Char.new("Arqueiro", 50, _G.height - 75, 10, target))
end

function love.update(dt)
    world:update(dt)

    for i = 1, #chars, 1 do
        chars[i]:update(dt)
    end
end

function love.draw()
    love.graphics.rectangle("fill",
        groundBody:getX() - 400, groundBody:getY() - 25,
        800, 50
    )

    target:draw()

    for i = 1, #chars, 1 do
        chars[i]:draw()
    end

    love.graphics.print("Gold: " .._G.player.gold)
end

---@diagnostic disable-next-line: lowercase-global
function beginContact(a, b, coll)
    local objA = a:getUserData()
    local objB = b:getUserData()

    if not objA or not objB then return end

    if (objA.type == 'projectile' and objB.type == 'target') or
       (objB.type == 'projectile' and objA.type == 'target') then

        local proj = objA.type == 'projectile' and objA or objB

        -- Aumenta o gold
        _G.player.gold = _G.player.gold + 1

        -- Marca o projétil como atingido
        proj.hit = true

        -- Remove o corpo do projétil
        proj.projectileBody:destroy()
    end
end

if arg[2] == "debug" then
    require("lldebugger").start()
end