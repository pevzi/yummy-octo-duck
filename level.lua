local sti = require "libs.sti"
local gamera = require "libs.gamera"
local bump = require "libs.bump"
local Object = require "libs.class"

local Level = Object:inherit()

function Level:init(n)
    self.world = bump.newWorld()

    self.map = sti.new(("levels/%d.lua"):format(n))

    local obstacles = self.map.layers.obstacles

    for y = 1, obstacles.height do
        for x = 1, obstacles.width do
            local tile = obstacles.data[y][x]

            if tile then
                -- TODO: specify an object
                self.world:add({}, (x - 1) * tile.width, (y - 1) * tile.height, tile.width, tile.height)
            end
        end
    end
end

function Level:update(dt)
    self.map:update(dt)
end

function Level:draw()
    self.map:draw()
end

return Level
