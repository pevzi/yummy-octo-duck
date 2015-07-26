--
-- A slightly modified version of classic.lua
--
-- Copyright (c) 2014, rxi
--
-- Permission is hereby granted, free of charge, to any person obtaining a
-- copy of this software and associated documentation files (the "Software"),
-- to deal in the Software without restriction, including without limitation
-- the rights to use, copy, modify, merge, publish, distribute, sublicense,
-- and/or sell copies of the Software, and to permit persons to whom the
-- Software is furnished to do so, subject to the following conditions:

-- The above copyright notice and this permission notice shall be included in
-- all copies or substantial portions of the Software.

-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
-- FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
-- DEALINGS IN THE SOFTWARE.

local Object = {}
Object.__index = Object

function Object:__call(...)
    local obj = setmetatable({}, self)

    obj:init(...)

    return obj
end

function Object:init()

end

function Object:inherit()
    local cls = {}

    for k, v in pairs(self) do
        if k:match("^__") then
            cls[k] = v
        end
    end

    cls.super = self
    cls.__index = cls

    return setmetatable(cls, self)
end

function Object:include(...)
    for _, cls in ipairs{...} do
        for k, v in pairs(cls) do
            if self[k] == nil and type(v) == "function" then
                self[k] = v
            end
        end
    end
end

function Object:is(cls)
    local mt = getmetatable(self)

    while mt do
        if mt == cls then
            return true
        end

        mt = getmetatable(mt)
    end

    return false
end

return Object
