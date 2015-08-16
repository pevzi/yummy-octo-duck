local Entity = require "entities.entity"

local class = require "libs.middleclass"

local Tile = class("Tile", Entity)

function Tile:initialize(tileType, world, x, y, w, h)
    self.class.super.initialize(self, world, x, y, w, h)

    self.type = tileType
end

return Tile
