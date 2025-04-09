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
    target = Target.new()
    table.insert(chars, 1, Char.new("Arqueiro", 10, 100, _G.height - 100, target))
    table.insert(chars, 2, Char.new("Ninja", 5, 150, _G.height - 150, target))
end

function love.update(dt)
    for i = 1, #chars, 1 do
        chars[i]:update(dt)
    end
end

function love.draw()
    target:draw()
    for i = 1, #chars, 1 do
        chars[i]:draw()
    end
    love.graphics.print("Gold: " .._G.player.gold)
end

if arg[2] == "debug" then
    require("lldebugger").start()
end