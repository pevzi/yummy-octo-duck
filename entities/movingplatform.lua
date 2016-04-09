local Entity = require "entities.entity"

local class = require "libs.middleclass"

local function lerp(x1, y1, x2, y2, position)
    return (x2 - x1) * position + x1,
           (y2 - y1) * position + y1
end

local MovingPlatform = class("MovingPlatform", Entity)

function MovingPlatform:initialize(world, x1, y1, x2, y2, velocity, position, dir, w, h)
    self.x1 = x1
    self.y1 = y1
    self.x2 = x2
    self.y2 = y2
    self.velocity = velocity -- TODO: probably provide pixelwise velocity instead
    self.position = position
    self.dir = dir
    self.w = w
    self.h = h

    self.x, self.y = lerp(x1, y1, x2, y2, position)
    self.oldX, self.oldY = self.x, self.y

    MovingPlatform.super.initialize(self, world, self.x, self.y, w, h)
end

function MovingPlatform:filter(other)
    if other.y + other.h <= self.oldY then
        return "cross"
    end
end

function MovingPlatform:update(dt)
    self.position = self.position + self.velocity * self.dir * dt

    if self.position > 1 then
        self.position = 1
        self.dir = -self.dir
    elseif self.position < 0 then
        self.position = 0
        self.dir = -self.dir
    end

    self.oldX, self.oldY = self.x, self.y
    self.x, self.y = lerp(self.x1, self.y1, self.x2, self.y2, self.position)

    self.vx = (self.x - self.oldX) / dt
    self.vy = (self.y - self.oldY) / dt

    local _, _, cols, len = self.world:move(self, self.x, self.y, self.filter)

    for i, col in ipairs(cols) do
        col.other.ground = self
    end
end

function MovingPlatform:draw()
    love.graphics.setColor(80, 80, 80)
    love.graphics.setLineWidth(2)
    love.graphics.rectangle("line", self.x, self.y, self.w, self.h, 4)
end

return MovingPlatform
