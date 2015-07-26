local tactile = require "libs.tactile"

local keyLeft = tactile.key "left"
local keyRight = tactile.key "right"
local keyUp = tactile.key "up"
local keySpace = tactile.key " "

local keyXAxis = tactile.binaryAxis(keyLeft, keyRight)

local horizontal = tactile.newAxis(keyXAxis)
local jump = tactile.newButton(keyUp, keySpace)

local function update()
    jump:update()
end

return {
    update = update,
    horizontal = horizontal,
    jump = jump
}
