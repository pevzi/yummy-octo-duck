local Level = require "level"

local Play = {}

function Play:enteredState()
    love.graphics.setBackgroundColor(255, 255, 255)

    self.level = Level(1)
end

function Play:update(dt)
    self.level:update(dt)
end

function Play:draw()
    self.level:draw()
end

return Play
