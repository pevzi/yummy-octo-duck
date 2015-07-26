local Level = require "level"
local Player = require "player"

local game = {}

function game:init()
    love.graphics.setBackgroundColor(255, 255, 255)

    self.level = Level(1)
    self.player = Player(50, 200, self.level.world) -- it's better to store the player in a STI layer
end

function game:update(dt)
    self.level:update(dt)
    self.player:update(dt)
end

function game:draw()
    self.level:draw()
    self.player:draw()
end

return game
