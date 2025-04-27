local love = require("love")
local Background = {}
Background.__index = Background

function Background.new()
    local self = setmetatable({}, Background)

    self.imgs = Background.createNewImages(self)
    self.layers = Background.setLayers(self)

    return self
end

function Background:setLayers()
    local layers = {}

    for i = 1, #self.imgs, 1 do
        table.insert(layers, {
            type = "fullscreen",
            image = self.imgs[i],
            x = 0,
            y = 0,
            speed = 0,
            parallax = false
        })
    end

    return layers
end

function Background:createNewImages()
    local imgs = {}

    table.insert(imgs, love.graphics.newImage("assets/bg/PNG/01.png"))
    table.insert(imgs, love.graphics.newImage("assets/bg/PNG/02.png"))
    table.insert(imgs, love.graphics.newImage("assets/bg/PNG/03.png"))
    table.insert(imgs, love.graphics.newImage("assets/bg/PNG/04.png"))
    table.insert(imgs, love.graphics.newImage("assets/bg/PNG/05.png"))
    table.insert(imgs, love.graphics.newImage("assets/bg/PNG/06.png"))

    for i = 1, #imgs, 1 do
        imgs[i]:setFilter("nearest", "nearest")
    end

    return imgs
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

