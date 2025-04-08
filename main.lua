local love = require("love")
local Char = require("char/Char")
local Target = require("target/Target")

local chars = {}
local target = {}

_G.height = love.graphics.getHeight();
_G.width = love.graphics.getWidth();
_G.gold = 0

function love.load()
    table.insert(chars, 1, Char.new("Arqueiro", 10, 100, _G.height - 100))
    table.insert(chars, 2, Char.new("Ninja", 5, 150, _G.height - 150))
    target = Target.new()
end

function love.update(dt)
    for i = 1, #chars, 1 do
        chars[i]:update(dt)
    end
end

function love.draw()
    for i = 1, #chars, 1 do
        chars[i]:draw()
    end

    target:draw()
end

if arg[2] == "debug" then
    require("lldebugger").start()
end