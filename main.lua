local love = require("love")
local Char = require("char/Char")
local Target = require("target/Target")

local chars = {}
local target = {}

_G.height = love.graphics.getHeight();
_G.width = love.graphics.getWidth();
_G.gold = 0

function love.load()
    table.insert(chars, 1, Char.new("Arqueiro", 10))
    target = Target.new()
end

function love.update(dt)
    chars[1]:update(dt)
end

function love.draw()
    chars[1]:draw()
    target:draw()
end

if arg[2] == "debug" then
    require("lldebugger").start()
end