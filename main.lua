local input = require "input"

local play = require "gamestates.play"

local gamestate = require "libs.gamestate"

function love.load()
    gamestate.registerEvents()
    gamestate.switch(play)
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end

function love.update(dt)
    input.update()
end
