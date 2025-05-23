local Button = {}
Button.__index = Button

function Button.new(x, y, img_path, text, onClick)
    local self = setmetatable({}, Button)

    self.x = x
    self.y = y
    self.bg_img = love.graphics.newImage(img_path)
    self.bg_width = self.bg_img:getWidth()
    self.bg_height = self.bg_img:getHeight()
    self.text = text or "none"
    self.text_height = font:getHeight()
    self.text_width = font:getWidth(self.text)
    self.text_x = self.x + (self.bg_width / 2) - (self.text_width / 2)
    self.text_y = self.y + (self.bg_height / 2) - (self.text_height / 2)
    self.onClick = onClick or function() end
    self.is_hover = false

    return self
end

function Button:update(dt)
    local mouse_x, mouse_y = love.mouse.getPosition()

    self.is_hover = mouse_x >= self.x and mouse_x <= self.x + self.bg_width and
                   mouse_y >= self.y and mouse_y <= self.y + self.bg_height
end

function Button:draw()
    -- DRAW BTN SHOOT
    love.graphics.draw(self.bg_img, self.x, self.y, 0, 1, 1)

    -- PRINT TEXT SHOOT
    local text = "SHOOT"

    love.graphics.setColor(0, 0, 0)
    love.graphics.print(text, self.text_x, self.text_y)
    love.graphics.setColor(1, 1, 1)
end

function Button:mousepressed(x, y, button)
    if button == 1 and self.is_hover then
        self.onClick()
    end
end

return Button