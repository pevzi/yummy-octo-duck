local Play = require "gamestates.play"

local class = require "libs.middleclass"
local Stateful = require "libs.stateful"

local Game = class("Game"):include(Stateful)

function Game:initialize()
    self:gotoState("Play")
end

Game:addState("Play", Play)

return Game
