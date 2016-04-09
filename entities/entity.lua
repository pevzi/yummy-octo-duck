local class = require "libs.middleclass"

local Entity = class("Entity")

function Entity:initialize(world, x, y, w, h, image, quad)
    self.world = world
    self.x = x
    self.y = y
    self.w = w
    self.h = h

    self.vx = 0
    self.vy = 0

    self.image = image
    self.quad = quad

    world:add(self, x, y, w, h)
end

function Entity:update(dt)

end

function Entity:draw()
    love.graphics.setColor(255, 255, 255)

    if self.image then
        local x = math.floor(self.x)
        local y = math.floor(self.y)

        if self.quad then
            love.graphics.draw(self.image, self.quad, x, y)
        else
            love.graphics.draw(self.image, x, y)
        end
    end
end

function Entity:destroy()
    self.world:remove(self)
end

return Entity
