local input = require "input"
local r = require "resources"
local u = require "useful"

local Entity = require "entities.entity"

local anim8 = require "libs.anim8"
local class = require "libs.middleclass"

local spriteW, spriteH = 64, 64

local Player = class("Player", Entity)

function Player:initialize(world, x, y)
    Player.super.initialize(self, world, x, y, 16, 32)

    self.vx = 0
    self.vy = 0

    self.jumpTimeMax = 0.3
    self.jumpTime = 0
    self.jumpInitial = 400
    self.jumpAcceleration = 1100 -- should be less than gravity

    self.landed = false

    self.vxmax = 180
    self.accx = 1000
    self.gravity = 1400

    self.scale = self.h / spriteH
    self.ox = (spriteW - self.w / self.scale) / 2
    self.oy = (spriteH - self.h / self.scale) / 2

    self.image = r.images.player

    local grid = anim8.newGrid(spriteW, spriteH, self.image:getWidth(), self.image:getHeight())
    self.animation = anim8.newAnimation(grid(1,1, 2,1), 0.1)
end

function Player:update(dt)
    local dir = input.horizontal:getValue()

    local tovx

    if dir == 0 then
        tovx = 0
        self.animation:pauseAtEnd()
    else
        tovx = dir * self.vxmax
        self.animation.flippedH = dir < 0
        self.animation:resume()
    end

    self.vx = u.valueTo(self.vx, tovx, self.accx, dt)

    if not self.landed then
        self.animation:pauseAtStart()
    end

    self.animation:update(dt)

    -- varying-height jump handling

    if input.jump:pressed() and self.landed then
        self.vy = -self.jumpInitial
        self.jumpTime = self.jumpTimeMax

    elseif input.jump:isDown() and self.jumpTime > 0 then
        self.vy = self.vy - self.jumpAcceleration * dt
        self.jumpTime = self.jumpTime - dt

    elseif input.jump:released() then
        self.jumpTime = 0
    end

    self.vy = self.vy + self.gravity * dt

    local newX = self.x + self.vx * dt
    local newY = self.y + self.vy * dt

    local actualX, actualY, cols, len = self.world:move(self, newX, newY)

    self.landed = false

    for i, col in ipairs(cols) do
        if col.normal.x == 0 then -- floor or ceiling
            self.vy = 0

            if col.normal.y < 0 then -- floor
                self.landed = true
            else -- ceiling
                self.jumpTime = 0
            end
        else
            if col.other.class.name == "Crate" then
                col.other.vx = self.vx
            else -- wall
                self.vx = 0
            end
        end
    end

    self.x = actualX
    self.y = actualY
end

function Player:draw()
    self.animation:draw(self.image, self.x, self.y, 0, self.scale, self.scale, self.ox, self.oy)
end

return Player
