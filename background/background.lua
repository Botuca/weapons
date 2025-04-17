local love = require("love")
local Background = {}
Background.__index = Background

function Background.new()
    local self = setmetatable({}, Background)

    self.layers = {
        {
            type = "fullscreen",
            image = love.graphics.newImage("assets/Clouds/Clouds8/1.png"),
            x = 0,
            y = 0,
            speed = 0,
            parallax = false
        },
        {
            type = "fullscreen",
            image = love.graphics.newImage("assets/Clouds/Clouds1/2.png"),
            x = 0,
            y = -80,
            speed = 0,
            parallax = false
        },
        {
            type = "fullscreen",
            image = love.graphics.newImage("assets/Clouds/Clouds1/4.png"),
            x = 0,
            y = -50,
            speed = 0,
            parallax = false
        },
        {
            type = "fullscreen",
            image = love.graphics.newImage("assets/Nature/nature_1/3.png"),
            x = 0,
            y = -20,
            speed = 0,
            parallax = false
        },
        {
            type = "fullscreen",
            image = love.graphics.newImage("assets/Nature/nature_2/4.png"),
            x = 0,
            y = 0,
            speed = 0,
            parallax = false
        },
    }

    return self
end

function Background:update(dt)
    for _, layer in ipairs(self.layers) do
        if layer.parallax then
            layer.x = (layer.x - layer.speed * 60 * dt) % layer.image:getWidth()
        end
    end
end

function Background:draw()
    for _, layer in ipairs(self.layers) do
        local img = layer.image

        local imgWidth = layer.image:getWidth()
        local imgHeight = layer.image:getHeight()

        local scaleX = _G.width / imgWidth
        local scaleY = _G.height / imgHeight

        if layer.type == "fullscreen" then
            love.graphics.draw(img, layer.x, layer.y, 0, scaleX, scaleY)
        else
            love.graphics.draw(img, layer.x, layer.y)
        end

        if layer.parallax then
            if layer.type == "fullscreen" then
                love.graphics.draw(img, layer.x - img:getWidth(), layer.y, 0, scaleX, scaleY)
            else
                love.graphics.draw(img, layer.x, layer.y)
            end
        end
    end
end

return Background

