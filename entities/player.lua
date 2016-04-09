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

    self.rvx = 0

    self.jumpTimeMax = 0.3
    self.jumpTime = 0
    self.jumpInitial = 400
    self.jumpAcceleration = 1100 -- should be less than gravity

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

function Player:filter(other)
    if other.class.name == "MovingPlatform" then
        if self.y + self.h <= other.y then
            return "slide"
        end
    else
        return "slide"
    end
end

function Player:update(dt)
    local dir = input.horizontal:getValue()

    if dir == 0 then
        self.animation:pauseAtEnd()
    else
        self.animation.flippedH = dir < 0
        self.animation:resume()
    end

    self.rvx = u.valueTo(self.rvx, self.vxmax * dir, self.accx * dt)

    if self.ground then
        self.vx = self.rvx + self.ground.vx
        self.y = self.ground.y - self.h
        self.world:update(self, self.x, self.y)
    else
        self.vx = self.rvx
    end

    if not self.ground then
        self.animation:pauseAtStart()
    end

    self.animation:update(dt)

    -- varying-height jump handling

    if input.jump:pressed() and self.ground then
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

    local actualX, actualY, cols, len = self.world:move(self, newX, newY, self.filter)

    self.ground = nil

    for i, col in ipairs(cols) do
        if col.normal.x == 0 then -- floor or ceiling
            self.vy = 0

            if col.normal.y < 0 then -- floor
                self.ground = col.other
            else -- ceiling
                self.jumpTime = 0
            end
        else
            if col.other.class.name == "Crate" then
                col.other.vx = self.vx
            else -- wall
                self.rvx = 0
            end
        end
    end

    self.x = actualX
    self.y = actualY
end

function Player:draw()
    love.graphics.setColor(255, 255, 255)
    self.animation:draw(self.image, self.x, self.y, 0, self.scale, self.scale, self.ox, self.oy)
end

return Player
