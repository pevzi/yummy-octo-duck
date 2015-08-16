local class = require "libs.middleclass"

local Entity = class("Entity")

function Entity:initialize(world, x, y, w, h, image, quad)
    self.world = world
    self.x = x
    self.y = y
    self.w = w
    self.h = h

    self.image = image
    self.quad = quad

    world:add(self, x, y, w, h)
end

function Entity:update(dt)

end

function Entity:draw()
    if self.image then
        if self.quad then
            love.graphics.draw(self.image, self.quad, self.x, self.y)
        else
            love.graphics.draw(self.image, self.x, self.y)
        end
    end
end

function Entity:destroy()
    self.world:remove(self)
end

return Entity
