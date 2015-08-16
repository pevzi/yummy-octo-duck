local Level = require "level"

local Player = require "entities.player"

local play = {}

function play:init()
    love.graphics.setBackgroundColor(255, 255, 255)

    self.level = Level(1)
end

function play:update(dt)
    self.level:update(dt)
end

function play:draw()
    self.level:draw()
end

return play
