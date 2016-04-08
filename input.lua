local tactile = require "libs.tactile"

local controls = {
    horizontal = tactile.newControl()
        :addButtonPair(tactile.keys("a", "left"), tactile.keys("d", "right")),
    jump = tactile.newControl()
        :addButton(tactile.keys("up", "space"))
}

local function update()
    for _, control in pairs(controls) do
        control:update()
    end
end

return setmetatable(controls, {__index = {update = update}})
