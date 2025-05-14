local Audio = {}
Audio.__index = Audio

function Audio.new()
    local self = setmetatable({}, Audio)

    self.sounds = {}

    return self
end

function Audio:load(name, path)
    self.sounds[name] = love.audio.newSource(path, "static")
end

function Audio:play(name)
    local sound = self.sounds[name]
    if sound then
        local clone = sound:clone()
        clone:play()
    end
end

return Audio
