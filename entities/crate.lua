local u = require "useful"

local Entity = require "entities.entity"

local class = require "libs.middleclass"

local Crate = class("Crate", Entity)

function Crate:initialize(world, x, y, w, h, image, quad)
    Crate.super.initialize(self, world, x, y, w, h, image, quad)

    self.vx = 0
    self.vy = 0

    self.accx = 500
    self.gravity = 1400
end

function Crate:update(dt)
    self.vx = u.valueTo(self.vx, 0, self.accx * dt)
    self.vy = self.vy + self.gravity * dt

    local newX = self.x + self.vx * dt
    local newY = self.y + self.vy * dt

    local actualX, actualY, cols, len = self.world:move(self, newX, newY)

    for _, col in ipairs(cols) do
        if col.normal.x == 0 and col.normal.y < 0 then -- floor
            self.vy = 0
        elseif col.normal.y == 0 then -- wall
            self.vx = 0
        end
    end

    self.x = actualX
    self.y = actualY
end

return Crate
