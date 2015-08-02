local Level = require "level"

local Player = require "entities.player"

local play = {}

function play:init()
    love.graphics.setBackgroundColor(255, 255, 255)

    self.level = Level(1)
    self.player = Player(50, 200, self.level.world) -- it's better to store the player in a STI layer
end

function play:update(dt)
    self.level:update(dt)
    self.player:update(dt)
end

function play:draw()
    self.level:draw()
    self.player:draw()
end

return play
