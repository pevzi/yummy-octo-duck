local Player = require "entities.player"
local Crate = require "entities.crate"
local Tile = require "entities.tile"

local sti = require "libs.sti"
local gamera = require "libs.gamera"
local bump = require "libs.bump"
local class = require "libs.middleclass"

local function extractImage(map, obj)
    local tile = obj.gid and map.tiles[obj.gid]

    if tile then
        local image = map.tilesets[tile.tileset].image
        local quad = tile.quad

        return image, quad
    end
end

local function initObjects(world, map, layerIndex)
    local layer = map.layers[layerIndex]

    if not layer or not layer.objects then
        return
    end

    local entities = {}

    for _, obj in ipairs(layer.objects) do
        local entity

        if obj.type == "player" then
            entity = Player(world, obj.x, obj.y - obj.height)
        elseif obj.type == "crate" then
            entity = Crate(world, obj.x, obj.y - obj.height, obj.width, obj.height, extractImage(map, obj))
        end

        if entity then
            entities[entity] = true
        end
    end

    map:convertToCustomLayer(layerIndex)

    layer.entities = entities

    function layer:update(dt)
        for entity in pairs(self.entities) do
            entity:update(dt)
        end
    end

    function layer:draw()
        for entity in pairs(self.entities) do
            entity:draw()
        end
    end
end

local function initTiles(world, map, layerIndex)
    local layer = map.layers[layerIndex]

    for y = 1, layer.height do
        for x = 1, layer.width do
            local tile = layer.data[y][x]

            if tile then
                Tile(layerIndex, world, (x - 1) * tile.width, (y - 1) * tile.height, tile.width, tile.height)
            end
        end
    end
end

local Level = class("Level")

function Level:initialize(n)
    self.map = sti.new(("levels/%d.lua"):format(n))

    self.world = bump.newWorld(self.map.tilewidth * 2)

    initObjects(self.world, self.map, "characters")
    initObjects(self.world, self.map, "interactable")

    initTiles(self.world, self.map, "impassable")
end

function Level:update(dt)
    self.map:update(dt)
end

function Level:draw()
    self.map:draw()
end

return Level
