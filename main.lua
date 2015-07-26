local game = require "game"
local input = require "input"

local gamestate = require "libs.gamestate"

function love.load()
    gamestate.registerEvents()
    gamestate.switch(game)
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end

function love.update(dt)
    input.update()
end
