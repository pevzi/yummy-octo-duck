local input = require "input"
local r = require "resources"

local anim8 = require "libs.anim8"
local Object = require "libs.class"

local spriteW, spriteH = 64, 64

local Player = Object:inherit()

function Player:init(x, y, world)
    self.x = x
    self.y = y

    self.vx = 0
    self.vy = 0

    self.jumpTimeMax = 0.3
    self.jumpTime = self.jumpTimeMax
    self.jumpInitial = 400
    self.jumpAcceleration = 1100 -- should be less than gravity

    self.landed = false
    self.falling = true

    self.vmax = 180
    self.gravity = 1400

    self.w = 16
    self.h = 32
    self.scale = self.h / spriteH
    self.ox = (spriteW - self.w / self.scale) / 2
    self.oy = (spriteH - self.h / self.scale) / 2

    self.image = r.images.player

    local grid = anim8.newGrid(spriteW, spriteH, self.image:getWidth(), self.image:getHeight())
    self.animation = anim8.newAnimation(grid(1,1, 2,1), 0.1)

    self.world = world

    world:add(self, x, y, self.w, self.h)
end

function Player:update(dt)
    self.animation:resume()

    local dir = input.horizontal:getValue()

    if dir == 0 then
        self.vx = 0
        self.animation:pauseAtEnd()
    else
        self.vx = self.vmax * dir
        self.animation.flippedH = dir < 0
    end

    if not self.landed then
        self.animation:pauseAtStart()
    end

    self.animation:update(dt)

    -- varying-height jump handling
    if input.jump:isDown() then

        -- if the player is on the ground then give them an initial impulse
        if self.landed then
            self.vy = -self.jumpInitial

        -- if the player is in the air and the jump button is just pressed then block any attempts to
        -- accelerate until the player lands on the ground
        elseif input.jump:pressed() then
            self.falling = true

        -- if the player is in the air and the jump button has been already down then check if acceleration
        -- isn't blocked and the player has "fuel" to accelerate, if successful then give the player
        -- some additional speed
        elseif not self.falling and self.jumpTime > 0 then
            self.vy = self.vy - self.jumpAcceleration * dt
            self.jumpTime = self.jumpTime - dt
        end
    end

    self.vy = self.vy + self.gravity * dt

    local newX = self.x + self.vx * dt
    local newY = self.y + self.vy * dt

    local actualX, actualY, cols, len = self.world:move(self, newX, newY)

    self.landed = false

    if len > 0 then
        for i, col in ipairs(cols) do
            if col.normal.x == 0 then -- floor or ceiling
                self.vx = 0 -- wha?
                self.vy = 0

                if col.normal.y < 0 then -- floor
                    self.jumpTime = self.jumpTimeMax
                    self.landed = true
                    self.falling = false
                    break
                end
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
