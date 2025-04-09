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
    _G.world = love.physics.newWorld(0, 500, true)

    _G.groundBody = love.physics.newBody(world, 400, 550, "static")
    _G.groundShape = love.physics.newRectangleShape(800, 50)
    _G.groundFixture = love.physics.newFixture(groundBody, groundShape)

    target = Target.new()

    table.insert(chars, 1, Char.new("Arqueiro", 150, _G.height - 155, 10, target))
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

if arg[2] == "debug" then
    require("lldebugger").start()
end