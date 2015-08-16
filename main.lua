local input = require "input"
local Game = require "game"

local game

function love.load()
    game = Game()
end

function love.update(dt)
    input.update()

    game:update(dt)
end

function love.draw()
    game:draw()
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end
